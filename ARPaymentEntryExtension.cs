using PX.Data;
using PX.Objects.AP;
using PX.Objects.AR;
using PX.Objects.CS;
using PX.Objects.IN;
using PX.Objects.SO;
using PX.SM;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace ARExtension
{
    public class ARPaymentEntryExtension : PXGraphExtension<ARPaymentEntry>
    {
        protected virtual void ARPayment_RowSelected(PXCache cache, PXRowSelectedEventArgs e)
        {

            this.selectInvoices.SetEnabled(Base.loadInvoices.GetEnabled());

        }
        public const string Open = "N";
        public class open : Constant<string>
        {
            public open()
            : base(Open)
            {
            }

        }
        public PXSelect<ARInvoice, Where<ARInvoice.customerID, Equal<Current<ARPayment.customerID>>, And<ARInvoice.status, Equal<open>>>> Adjustments2;
        //public PXSelect<ARInvoice, Where<ARInvoice.status, Equal<open>>> Adjustments2;

        protected virtual IEnumerable adjustments2()
        {

            PXGraph graph = Base;
            var opts = Base.loadOpts.Current;
            ARPayment currentDoc = Base.Document.Current;
            PXResultset<ARInvoice> custdocs = GetCustDocs(opts, currentDoc, Base.arsetup.Current, graph);
            return custdocs;

        }
        public class LoadOptionsExtension : PXCacheExtension<PX.Objects.AR.ARPaymentEntry.LoadOptions>
        {
            #region StartRefNbr
            [PXDBString(15, IsUnicode = true)]
            [PXUIField(DisplayName = "Start Ref. Nbr.")]
            [PXSelector(
                typeof(Search<ARInvoice.refNbr,
                Where<ARInvoice.customerID, Equal<Current<ARPayment.customerID>>,
                And<ARInvoice.status, Equal<open>>>>),
                typeof(ARInvoice.docType),
                typeof(ARInvoice.refNbr),
                typeof(ARInvoice.status))]
            public string StartRefNbr { get; set; }
            #endregion

            #region EndRefNbr
            [PXDBString(15, IsUnicode = true)]
            [PXUIField(DisplayName = "End Ref. Nbr.")]
            [PXSelector(
                typeof(Search<ARInvoice.refNbr,
                Where<ARInvoice.customerID, Equal<Current<ARPayment.customerID>>,
                And<ARInvoice.status, Equal<open>>>>),
                typeof(ARInvoice.docType),
                typeof(ARInvoice.refNbr),
                typeof(ARInvoice.status))]
            public string EndRefNbr { get; set; }
            #endregion
            //[PXDBString(15, IsUnicode = true), PXSelector(typeof(Search2<ARInvoice.refNbr, InnerJoin<Customer, On<Customer.bAccountID, Equal<ARInvoice.customerID>>, LeftJoin<ARAdjust, On<ARAdjust.adjdDocType, Equal<ARInvoice.docType>, And<ARAdjust.adjdRefNbr, Equal<ARInvoice.refNbr>, And<ARAdjust.released, Equal<boolFalse>, And<ARAdjust.voided, Equal<boolFalse>, And<Where<ARAdjust.adjgDocType, NotEqual<Current<ARPayment.docType>>, Or<ARAdjust.adjgRefNbr, NotEqual<Current<ARPayment.refNbr>>>>>>>>>>>, Where<ARInvoice.released, Equal<boolTrue>, And<ARInvoice.openDoc, Equal<boolTrue>, And<ARInvoice.dueDate, IsNotNull, And<ARInvoice.docDate, LessEqual<Current<ARPayment.adjDate>>, And<ARRegister.finPeriodID, LessEqual<Current<ARPayment.adjFinPeriodID>>, And<ARAdjust.adjgRefNbr, IsNull, And<Where<ARInvoice.customerID, Equal<Optional<ARPayment.customerID>>, Or<Customer.consolidatingBAccountID, Equal<Optional<ARRegister.customerID>>>>>>>>>>>>)), PXUIField(DisplayName = "Start Ref. Nbr.")]
            //public string StartRefNbr
            //{
            //	get;
            //	set;

            //}
        }
        [Serializable]
        public class LoadOptions2 : PX.Objects.AR.ARPaymentEntry.LoadOptions
        {
            [PXDBString(15, IsUnicode = true)]
            [PXUIField(DisplayName = "Start Ref. Nbr.")]
            [PXSelector(
                typeof(Search<ARInvoice.refNbr,
                Where<ARInvoice.customerID, Equal<Current<ARPayment.customerID>>,
                And<ARInvoice.status, Equal<open>>>>),
                typeof(ARInvoice.refNbr),
                typeof(ARInvoice.customerID),
                typeof(ARInvoice.status))]
            public override string StartRefNbr { get; set; }
        }

        public PXFilter<ARPayment> arpaymentFilter;
        //the action (small case)
        public PXAction<ARPayment> selectInvoices;
        //the action (upper case)
        [PXUIField(DisplayName = "Select Documents", MapEnableRights = PXCacheRights.Select, MapViewRights = PXCacheRights.Select)]
        [PXLookupButton]
        public virtual IEnumerable SelectInvoices(PXAdapter adapter)
        {

            if (Adjustments2.AskExt() == WebDialogResult.OK)
            {
                LoadInvoicesProc(false, Base.loadOpts.Current);

            }
            Adjustments2.View.Clear();
            Adjustments2.Cache.Clear();

            return adapter.Get();
        }

        //[PXFilterable]
        //[PXCopyPasteHiddenView]
        //public PXSelectJoin<ARAdjust, 
        //		LeftJoin<ARInvoice, On<ARInvoice.docType, Equal<ARAdjust.adjdDocType>, 
        //			And<ARInvoice.refNbr, Equal<ARAdjust.adjdRefNbr>>>>,
        //		Where<ARAdjust.adjgDocType, Equal<Current<ARPayment.docType>>,
        //			And<ARAdjust.adjgRefNbr, Equal<Current<ARPayment.refNbr>>,
        //			And<ARAdjust.adjNbr, Equal<Current<ARPayment.lineCntr>>>>>> Adjustments2;



        protected bool internalCall = false;
        protected bool InternalCall = false;
        public virtual void LoadInvoicesProc(bool LoadExistingOnly, PX.Objects.AR.ARPaymentEntry.LoadOptions opts)
        {
            Dictionary<string, ARAdjust> existing = new Dictionary<string, ARAdjust>();
            ARPayment currentDoc = Base.Document.Current;
            InternalCall = true;
            try
            {
                if (currentDoc == null || currentDoc.CustomerID == null || currentDoc.OpenDoc == false || currentDoc.DocType != ARDocType.Payment && currentDoc.DocType != ARDocType.Prepayment && currentDoc.DocType != ARDocType.CreditMemo)
                {
                    throw new PXLoadInvoiceException();
                }

                foreach (PXResult<ARAdjust> res in Base.Adjustments_Raw.Select())
                {

                    ARAdjust old_adj = (ARAdjust)res;

                    if (LoadExistingOnly == false)
                    {
                        old_adj = PXCache<ARAdjust>.CreateCopy(old_adj);
                        old_adj.CuryAdjgAmt = null;
                        old_adj.CuryAdjgDiscAmt = null;
                    }

                    string s = string.Format("{0}_{1}", old_adj.AdjdDocType, old_adj.AdjdRefNbr);
                    existing.Add(s, old_adj);
                    Base.Adjustments.Cache.Delete((ARAdjust)res);
                }

                currentDoc.LineCntr++;
                if (Base.Document.Cache.GetStatus(currentDoc) == PXEntryStatus.Notchanged || Base.Document.Cache.GetStatus(currentDoc) == PXEntryStatus.Held)
                {
                    Base.Document.Cache.SetStatus(currentDoc, PXEntryStatus.Updated);
                }
                Base.Document.Cache.IsDirty = true;

                foreach (KeyValuePair<string, ARAdjust> res in existing)
                {
                    ARAdjust adj = new ARAdjust();
                    adj.AdjdDocType = res.Value.AdjdDocType;
                    adj.AdjdRefNbr = res.Value.AdjdRefNbr;

                    try
                    {
                        adj = PXCache<ARAdjust>.CreateCopy(AddAdjustment(adj));
                        if (res.Value.CuryAdjgDiscAmt != null && res.Value.CuryAdjgDiscAmt < adj.CuryAdjgDiscAmt)
                        {
                            adj.CuryAdjgDiscAmt = res.Value.CuryAdjgDiscAmt;
                            adj = PXCache<ARAdjust>.CreateCopy((ARAdjust)Base.Adjustments.Cache.Update(adj));
                        }

                        if (res.Value.CuryAdjgAmt != null && res.Value.CuryAdjgAmt < adj.CuryAdjgAmt)
                        {
                            adj.CuryAdjgAmt = res.Value.CuryAdjgAmt;
                            Base.Adjustments.Cache.Update(adj);
                        }
                    }
                    catch (PXSetPropertyException) { }
                }

                if (LoadExistingOnly)
                {
                    return;
                }

                PXGraph graph = Base;
                PXResultset<ARInvoice> custdocs = GetCustDocs(opts, currentDoc, Base.arsetup.Current, graph);

                //changed from custdocs to Adjustments2.Cache.Updated
                foreach (ARInvoice invoice in Adjustments2.Cache.Updated)
                {
                    //if it is not checked, skip. else, insert it.
                    if (invoice.Selected != true)
                    {
                        continue;
                    }

                    string s = string.Format("{0}_{1}", invoice.DocType, invoice.RefNbr);
                    if (existing.ContainsKey(s) == false)
                    {
                        ARAdjust adj = new ARAdjust();
                        adj.AdjdDocType = invoice.DocType;
                        adj.AdjdRefNbr = invoice.RefNbr;

                        AddAdjustment(adj);
                    }
                }

                if (currentDoc.CuryApplAmt < 0m)
                {
                    List<ARAdjust> credits = new List<ARAdjust>();

                    foreach (ARAdjust adj in Base.Adjustments_Raw.Select())
                    {
                        if (adj.AdjdDocType == ARDocType.CreditMemo)
                        {
                            credits.Add(adj);
                        }
                    }

                    credits.Sort((a, b) =>
                    {
                        return ((IComparable)a.CuryAdjgAmt).CompareTo(b.CuryAdjgAmt);
                    });

                    foreach (ARAdjust adj in credits)
                    {
                        if (adj.CuryAdjgAmt <= -currentDoc.CuryApplAmt)
                        {
                            Base.Adjustments.Delete(adj);
                        }
                        else
                        {
                            ARAdjust copy = PXCache<ARAdjust>.CreateCopy(adj);
                            copy.CuryAdjgAmt += currentDoc.CuryApplAmt;
                            Base.Adjustments.Update(copy);
                        }
                    }
                }

            }
            catch (PXLoadInvoiceException)
            {
            }
            finally
            {
                InternalCall = false;
            }
        }

        public static PXResultset<ARInvoice> GetCustDocs(PX.Objects.AR.ARPaymentEntry.LoadOptions opts, ARPayment currentARPayment, ARSetup currentARSetup, PXGraph graph)
        {
            PXSelectBase<ARInvoice> cmd = new PXSelectReadonly2<ARInvoice,
                                        InnerJoin<Customer, On<Customer.bAccountID, Equal<ARInvoice.customerID>>,
                                        LeftJoin<ARAdjust, On<ARAdjust.adjdDocType, Equal<ARInvoice.docType>,
                                            And<ARAdjust.adjdRefNbr, Equal<ARInvoice.refNbr>, And<ARAdjust.released, Equal<boolFalse>,
                                            And<ARAdjust.voided, Equal<boolFalse>, And<Where<ARAdjust.adjgDocType, NotEqual<Required<ARPayment.docType>>,
                                            Or<ARAdjust.adjgRefNbr, NotEqual<Required<ARPayment.refNbr>>>>>>>>>,
                                        LeftJoin<ARAdjust2, On<ARAdjust2.adjgDocType, Equal<ARInvoice.docType>,
                                            And<ARAdjust2.adjgRefNbr, Equal<ARInvoice.refNbr>, And<ARAdjust2.released, Equal<boolFalse>,
                                            And<ARAdjust2.voided, Equal<boolFalse>>>>>>>>,
                                        Where<ARInvoice.docType, NotEqual<Required<ARPayment.docType>>,
                                            And<ARInvoice.released, Equal<boolTrue>,
                                            And<ARInvoice.openDoc, Equal<boolTrue>,
                                            And<ARAdjust.adjgRefNbr, IsNull,
                                            And<ARAdjust2.adjgRefNbr, IsNull>>>>>,
                                            OrderBy<Asc<ARInvoice.dueDate, Asc<ARInvoice.refNbr>>>>(graph);

            if (opts != null)
            {
                if (opts.FromDate != null)
                {
                    cmd.WhereAnd<Where<ARInvoice.docDate, GreaterEqual<Required<PX.Objects.AR.ARPaymentEntry.LoadOptions.fromDate>>>>();
                }
                if (opts.TillDate != null)
                {
                    cmd.WhereAnd<Where<ARInvoice.docDate, LessEqual<Required<PX.Objects.AR.ARPaymentEntry.LoadOptions.tillDate>>>>();
                }
                if (!string.IsNullOrEmpty(opts.StartRefNbr))
                {
                    cmd.WhereAnd<Where<ARInvoice.refNbr, GreaterEqual<Required<PX.Objects.AR.ARPaymentEntry.LoadOptions.startRefNbr>>>>();
                }
                if (!string.IsNullOrEmpty(opts.EndRefNbr))
                {
                    cmd.WhereAnd<Where<ARInvoice.refNbr, LessEqual<Required<PX.Objects.AR.ARPaymentEntry.LoadOptions.endRefNbr>>>>();
                }
            }

            var loadChildDocs = opts == null ? PX.Objects.AR.ARPaymentEntry.LoadOptions.loadChildDocuments.None : opts.LoadChildDocuments;
            switch (loadChildDocs)
            {
                case PX.Objects.AR.ARPaymentEntry.LoadOptions.loadChildDocuments.IncludeCRM:
                    cmd.WhereAnd<Where<ARInvoice.customerID, Equal<Required<ARRegister.customerID>>,
                                    Or<Customer.consolidatingBAccountID, Equal<Required<ARRegister.customerID>>>>>();
                    break;
                case PX.Objects.AR.ARPaymentEntry.LoadOptions.loadChildDocuments.ExcludeCRM:
                    cmd.WhereAnd<Where<ARInvoice.customerID, Equal<Required<ARRegister.customerID>>,
                                    Or<Customer.consolidatingBAccountID, Equal<Required<ARRegister.customerID>>,
                                        And<ARInvoice.docType, NotEqual<ARDocType.creditMemo>>>>>();
                    break;
                default:
                    cmd.WhereAnd<Where<ARInvoice.customerID, Equal<Required<ARRegister.customerID>>>>();
                    break;
            }

            switch (currentARPayment.DocType)
            {
                case ARDocType.Payment:
                    cmd.WhereAnd<Where<ARInvoice.docType, Equal<ARDocType.invoice>, Or<ARInvoice.docType, Equal<ARDocType.debitMemo>, Or<ARInvoice.docType, Equal<ARDocType.creditMemo>, Or<ARInvoice.docType, Equal<ARDocType.finCharge>>>>>>();
                    break;
                case ARDocType.Prepayment:
                case ARDocType.CreditMemo:
                    cmd.WhereAnd<Where<ARInvoice.docType, Equal<ARDocType.invoice>, Or<ARInvoice.docType, Equal<ARDocType.debitMemo>, Or<ARInvoice.docType, Equal<ARDocType.finCharge>>>>>();
                    break;
                default:
                    cmd.WhereAnd<Where<True, Equal<False>>>();
                    break;
            }
            List<object> parametrs = new List<object>();
            parametrs.Add(currentARPayment.DocType);
            parametrs.Add(currentARPayment.RefNbr);
            parametrs.Add(currentARPayment.DocType);
            if (opts != null)
            {
                if (opts.FromDate != null)
                {
                    parametrs.Add(opts.FromDate);
                }
                if (opts.TillDate != null)
                {
                    parametrs.Add(opts.TillDate);
                }
                if (!string.IsNullOrEmpty(opts.StartRefNbr))
                {
                    parametrs.Add(opts.StartRefNbr);
                }
                if (!string.IsNullOrEmpty(opts.EndRefNbr))
                {
                    parametrs.Add(opts.EndRefNbr);
                }
            }

            switch (loadChildDocs)
            {
                case PX.Objects.AR.ARPaymentEntry.LoadOptions.loadChildDocuments.IncludeCRM:
                case PX.Objects.AR.ARPaymentEntry.LoadOptions.loadChildDocuments.ExcludeCRM:
                    parametrs.Add(currentARPayment.CustomerID);
                    parametrs.Add(currentARPayment.CustomerID);
                    break;
                default:
                    parametrs.Add(currentARPayment.CustomerID);
                    break;
            }

            PXResultset<ARInvoice> custdocs = opts == null || opts.MaxDocs == null ? cmd.Select(parametrs.ToArray()) : cmd.SelectWindowed(0, (int)opts.MaxDocs, parametrs.ToArray());

            custdocs.Sort(new Comparison<PXResult<ARInvoice>>(delegate (PXResult<ARInvoice> a, PXResult<ARInvoice> b)
            {
                int aSortOrder = 0;
                int bSortOrder = 0;

                if (currentARPayment.CuryOrigDocAmt > 0m)
                {
                    aSortOrder += (((ARInvoice)a).DocType == ARDocType.CreditMemo ? 0 : 1000);
                    bSortOrder += (((ARInvoice)b).DocType == ARDocType.CreditMemo ? 0 : 1000);
                }
                else
                {
                    aSortOrder += (((ARInvoice)a).DocType == ARDocType.CreditMemo ? 1000 : 0);
                    bSortOrder += (((ARInvoice)b).DocType == ARDocType.CreditMemo ? 1000 : 0);
                }

                if (currentARSetup.FinChargeFirst == true)
                {
                    aSortOrder += (((ARInvoice)a).DocType == ARDocType.FinCharge ? 0 : 100);
                    bSortOrder += (((ARInvoice)b).DocType == ARDocType.FinCharge ? 0 : 100);
                }

                DateTime aDueDate = ((ARInvoice)a).DueDate ?? DateTime.MinValue;
                DateTime bDueDate = ((ARInvoice)b).DueDate ?? DateTime.MinValue;

                if (opts == null)
                {
                    aSortOrder += (1 + aDueDate.CompareTo(bDueDate)) / 2;
                    bSortOrder += (1 - aDueDate.CompareTo(bDueDate)) / 2;
                }
                else
                {
                    object aObj;
                    object bObj;

                    switch (opts.OrderBy)
                    {
                        case PX.Objects.AR.ARPaymentEntry.LoadOptions.orderBy.RefNbr:

                            aObj = ((ARInvoice)a).RefNbr;
                            bObj = ((ARInvoice)b).RefNbr;
                            aSortOrder += (1 + ((IComparable)aObj).CompareTo(bObj)) / 2;
                            bSortOrder += (1 - ((IComparable)aObj).CompareTo(bObj)) / 2;
                            break;

                        case PX.Objects.AR.ARPaymentEntry.LoadOptions.orderBy.DocDateRefNbr:

                            aObj = ((ARInvoice)a).DocDate;
                            bObj = ((ARInvoice)b).DocDate;
                            aSortOrder += (1 + ((IComparable)aObj).CompareTo(bObj)) / 2 * 10;
                            bSortOrder += (1 - ((IComparable)aObj).CompareTo(bObj)) / 2 * 10;

                            aObj = ((ARInvoice)a).RefNbr;
                            bObj = ((ARInvoice)b).RefNbr;
                            aSortOrder += (1 + ((IComparable)aObj).CompareTo(bObj)) / 2;
                            bSortOrder += (1 - ((IComparable)aObj).CompareTo(bObj)) / 2;
                            break;
                        default:
                            aSortOrder += (1 + aDueDate.CompareTo(bDueDate)) / 2 * 10;
                            bSortOrder += (1 - aDueDate.CompareTo(bDueDate)) / 2 * 10;


                            aObj = ((ARInvoice)a).RefNbr;
                            bObj = ((ARInvoice)b).RefNbr;
                            aSortOrder += (1 + ((IComparable)aObj).CompareTo(bObj)) / 2;
                            bSortOrder += (1 - ((IComparable)aObj).CompareTo(bObj)) / 2;
                            break;
                    }
                }
                return aSortOrder.CompareTo(bSortOrder);
            }));
            return custdocs;
        }
        private ARAdjust AddAdjustment(ARAdjust adj)
        {
            if (Base.Document.Current.CuryUnappliedBal == 0m && Base.Document.Current.CuryOrigDocAmt > 0m)
            {
                throw new PXLoadInvoiceException();
            }
            return Base.Adjustments.Insert(adj);
        }
        protected class PXLoadInvoiceException : Exception
        {
            public PXLoadInvoiceException() { }

            public PXLoadInvoiceException(SerializationInfo info, StreamingContext context)
                : base(info, context)
            { }
        }
    }
}

