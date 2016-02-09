<%@ Page Language="C#" MasterPageFile="~/MasterPages/FormDetail.master" AutoEventWireup="true" ValidateRequest="false" CodeFile="AR302000.aspx.cs" Inherits="Page_AR302000" Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPages/FormDetail.master" %>
<asp:Content ID="cont1" ContentPlaceHolderID="phDS" runat="Server">
	<px:PXDataSource ID="ds" runat="server" Visible="True" Width="100%" TypeName="PX.Objects.AR.ARPaymentEntry" PrimaryView="Document">
		<CallbackCommands>
			<px:PXDSCallbackCommand CommitChanges="True" Name="Save" PopupVisible="true" />
			<px:PXDSCallbackCommand Name="Insert" PostData="Self" />
			<px:PXDSCallbackCommand Name="First" PostData="Self" StartNewGroup="True" />
			<px:PXDSCallbackCommand Name="Last" PostData="Self" />
			<px:PXDSCallbackCommand StartNewGroup="True" Name="Release" PopupVisible="true" CommitChanges="true" />
			<px:PXDSCallbackCommand Visible="false" Name="ViewBatch" />
			<px:PXDSCallbackCommand Name="Action" CommitChanges="True" StartNewGroup="True" />
			<px:PXDSCallbackCommand Name="Inquiry" RepaintControls="All" CommitChanges="True" />
			<px:PXDSCallbackCommand Name="Report" CommitChanges="true" />
			<px:PXDSCallbackCommand Name="CurrencyView" Visible="False" />
			<px:PXDSCallbackCommand Name="NewCustomer" Visible="False" />
			<px:PXDSCallbackCommand Visible="false" Name="EditCustomer" />
			<px:PXDSCallbackCommand Visible="false" Name="CustomerDocuments" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="LoadInvoices" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="SelectInvoices" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="LoadOrders" />
			<px:PXDSCallbackCommand Visible="false" Name="ReverseApplication" CommitChanges="True" DependOnGrid="detgrid2" />
			<px:PXDSCallbackCommand Name="ViewDocumentToApply" DependOnGrid="detgrid" Visible="False" />
			<px:PXDSCallbackCommand Name="ViewSODocumentToApply" DependOnGrid="detgrid3" Visible="False" />
			<px:PXDSCallbackCommand Visible="false" Name="ViewApplicationDocument" DependOnGrid="detgrid2" />
			<px:PXDSCallbackCommand Visible="false" Name="ViewCurrentBatch" DependOnGrid="detgrid2" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="CaptureCCPayment" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="AuthorizeCCPayment" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="VoidCCPayment" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="CreditCCPayment" />						
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="RecordCCPayment" />
			<px:PXDSCallbackCommand Visible="false" CommitChanges="true" Name="CaptureOnlyCCPayment"/>
			
		</CallbackCommands>
	</px:PXDataSource>
	<px:PXSmartPanel ID="pnlRecordCCPayment" runat="server" Caption="Record CC Payment" CaptionVisible="True" Key="Document" LoadOnDemand="True" CommandSourceID="ds" ShowAfterLoad="True"
			Style="z-index: 108;" AutoCallBack-Command="Refresh" AutoCallBack-Target="frmCCPaymentInfo" CloseAfterAction="true">
		<px:PXFormView ID="frmCCPaymentInfo" runat="server" Caption="CC Payment Data" DataMember="ccPaymentInfo" Style="z-index: 100; border: none" CaptionVisible="False" SkinID="Transparent" DefaultControlID="edPCTranNumber">
			<Template>
				<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
				<px:PXTextEdit ID="edPCTranNumber" runat="server" DataField="PCTranNumber" />
				<px:PXTextEdit ID="edAuthNumber" runat="server" DataField="AuthNumber" />
			</Template>
		</px:PXFormView>
		<px:PXPanel ID="PXPanel1" runat="server" SkinID="Buttons">
			<px:PXButton ID="OK" runat="server" DialogResult="OK" Text="Save" />
		    <px:PXButton ID="Cancel" runat="server" DialogResult="Cancel" Text="Cancel" />
		</px:PXPanel>
	</px:PXSmartPanel>

	<px:PXSmartPanel ID="pnlCaptureCCOnly" runat="server" Caption="CC Payment with External Authorization" CaptionVisible="True" Key="ccPaymentInfo" 
			LoadOnDemand="True" CommandSourceID="ds" ShowAfterLoad="True"
		Style="z-index: 108;" AutoCallBack-Command="Refresh" AutoCallBack-Target="frmCCPaymentInfo1" CloseAfterAction="true">
		<px:PXFormView ID="frmCCPaymentInfo1" runat="server" Caption="CC Payment Data" DataMember="ccPaymentInfo" Style="z-index: 100; border: none" CaptionVisible="false" SkinID="Transparent" DefaultControlID="edAuthNumber">
			<Template>
				<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
				<px:PXTextEdit ID="PXTextEdit1" runat="server" DataField="AuthNumber" /></Template>
		</px:PXFormView>
		<px:PXPanel ID="PXPanel2" runat="server" SkinID="Buttons">
			<px:PXButton ID="PXButton1" runat="server" DialogResult="OK" Text="Save" />
		    <px:PXButton ID="PXButton2" runat="server" DialogResult="Cancel" Text="Cancel" />
		</px:PXPanel>
	</px:PXSmartPanel>
</asp:Content>
<asp:Content ID="cont2" ContentPlaceHolderID="phF" runat="Server">
	<px:PXFormView ID="form" runat="server" Style="z-index: 100" Width="100%" 
        DataMember="Document" Caption="Payment Summary" NoteIndicator="True" 
        FilesIndicator="True" ActivityIndicator="True" ActivityField="NoteActivity"
		LinkIndicator="True" NotifyIndicator="True" DefaultControlID="edDocType" 
        TabIndex="100" DataSourceID="ds" MarkRequired="Dynamic">
		<Template>
			<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="S" ControlSize="S" />
			<px:PXDropDown ID="edDocType" runat="server" DataField="DocType" SelectedIndex="-1">
			</px:PXDropDown>
			<px:PXSelector ID="edRefNbr" runat="server" DataField="RefNbr" 
                AutoRefresh="True" DataSourceID="ds">
				<GridProperties FastFilterFields="ExtRefNbr" />
			</px:PXSelector>
			<px:PXDropDown ID="edStatus" runat="server" DataField="Status" Enabled="False" />
			<px:PXCheckBox Size="s" CommitChanges="True" ID="chkHold" runat="server" DataField="Hold" />
			<px:PXDateTimeEdit CommitChanges="True" ID="edAdjDate" runat="server" DataField="AdjDate" />
			<px:PXSelector CommitChanges="True" ID="edAdjFinPeriodID" runat="server" 
                DataField="AdjFinPeriodID" DataSourceID="ds" />
		    <px:PXTextEdit ID="edExtRefNbr" runat="server" DataField="ExtRefNbr" CommitChanges="True"/>
			<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="S" ControlSize="XM" />
			<px:PXSegmentMask CommitChanges="True" ID="edCustomerID" runat="server" 
                DataField="CustomerID" AllowAddNew="True" AllowEdit="True" DataSourceID="ds" />
			<px:PXSegmentMask CommitChanges="True" ID="edCustomerLocationID" runat="server" 
                AutoRefresh="True" DataField="CustomerLocationID" DataSourceID="ds" />
			<px:PXSelector CommitChanges="True" ID="edPaymentMethodID" runat="server" 
                DataField="PaymentMethodID" AutoRefresh="True" AllowAddNew="True" 
                DataSourceID="ds" />
			<px:PXSelector CommitChanges="True" ID="edPMInstanceID" runat="server" 
                DataField="PMInstanceID" TextField="Descr" AutoRefresh="True" 
                AutoGenerateColumns="True" DataSourceID="ds" />
			<px:PXSegmentMask CommitChanges="True" ID="edCashAccountID" runat="server" 
                DataField="CashAccountID" AutoRefresh="True" DataSourceID="ds" />
			<pxa:PXCurrencyRate DataField="CuryID" ID="edCury" runat="server" 
                RateTypeView="_ARPayment_CurrencyInfo_" DataMember="_Currency_" 
                DataSourceID="ds"></pxa:PXCurrencyRate>
			<px:PXDateTimeEdit ID="edDepositAfter" runat="server" DataField="DepositAfter" CommitChanges="True"/>
			<px:PXLayoutRule runat="server" ColumnSpan="2" />
			<px:PXTextEdit ID="edDocDesc" runat="server" DataField="DocDesc" />
			<px:PXTextEdit ID="edCCPaymentStateDescr" runat="server" DataField="CCPaymentStateDescr" Enabled="False" />
			<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="S" ControlSize="S" />
			<px:PXNumberEdit CommitChanges="True" ID="edCuryOrigDocAmt" runat="server" DataField="CuryOrigDocAmt" />
			<px:PXNumberEdit ID="edCuryApplAmt" runat="server" DataField="CuryApplAmt" Enabled="False" />
			<px:PXNumberEdit ID="edCurySOApplAmt" runat="server" DataField="CurySOApplAmt" Enabled="False" />
			<px:PXNumberEdit ID="edCuryUnappliedBal" runat="server" DataField="CuryUnappliedBal" Enabled="False" />
			<px:PXNumberEdit ID="edCuryWOAmt" runat="server" DataField="CuryWOAmt" Enabled="False" />
			<px:PXNumberEdit ID="edCuryChargeAmt" runat="server" DataField="CuryChargeAmt" Enabled="False" />
            <px:PXNumberEdit ID="edCuryConsolidateChargeTotal" runat="server" DataField="CuryConsolidateChargeTotal" Enabled="False" />
			<px:PXCheckBox SuppressLabel="True" ID="chkIsCCPayment" runat="server" DataField="IsCCPayment" />
			<px:PXSelector ID="edRefTranExtNbr" runat="server" DataField="RefTranExtNbr" 
                ValueField="PCTranNumber" DataSourceID="ds">
				<Parameters>
					<px:PXControlParam ControlID="form" Name="ARPayment.pMInstanceID" PropertyName="DataControls[&quot;edPMInstanceID&quot;].Value" />
				</Parameters>
			</px:PXSelector>
			<px:PXLayoutRule ID="PXLayoutRule4" runat="server" StartColumn="True" ControlSize="M" />
			<px:PXCheckBox runat="server" DataField="IsRUTROTPayment" CommitChanges="True" Size="m" ID="chkIsRUTROT" AlignLeft="True" />
		</Template>
	</px:PXFormView>
</asp:Content>
<asp:Content ID="cont3" ContentPlaceHolderID="phG" runat="Server">
	<px:PXTab ID="tab" runat="server" Height="300px" Style="z-index: 100;" Width="100%" TabIndex="200">
		<Items>
			<px:PXTabItem Text="Documents to Apply">
				<Template>
					<px:PXGrid ID="detgrid" runat="server" Style="z-index: 100;" Width="100%" Height="300px" SkinID="DetailsInTab" AdjustPageSize="Auto" AllowPaging="True">
						<Levels>
							<px:PXGridLevel DataMember="Adjustments">
								<RowTemplate>
									<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
									<px:PXTextEdit ID="edAdjgDocType" runat="server" DataField="AdjgDocType" />
									<px:PXDropDown ID="edAdjdDocType" runat="server" AllowNull="False" DataField="AdjdDocType" />
									<px:PXSelector CommitChanges="True" ID="edAdjdRefNbr" runat="server" DataField="AdjdRefNbr" AutoRefresh="true">
										<Parameters>
											<px:PXControlParam ControlID="form" Name="ARPayment.customerID" PropertyName="DataControls[&quot;edCustomerID&quot;].Value" />
											<px:PXControlParam ControlID="detgrid" Name="ARAdjust.adjdDocType" PropertyName="DataValues[&quot;AdjdDocType&quot;]" />
										</Parameters>
									</px:PXSelector>
									<px:PXNumberEdit ID="edCuryAdjgAmt" runat="server" AllowNull="False" DataField="CuryAdjgAmt" />
									<px:PXNumberEdit ID="edCuryAdjgDiscAmt" runat="server" AllowNull="False" DataField="CuryAdjgDiscAmt" />
									<px:PXNumberEdit ID="edCuryAdjgWOAmt" runat="server" AllowNull="False" DataField="CuryAdjgWOAmt" />
									<px:PXDateTimeEdit ID="edAdjdDocDate" runat="server" DataField="AdjdDocDate" Enabled="False" />
									<px:PXDateTimeEdit ID="edARInvoice__DueDate" runat="server" DataField="ARInvoice__DueDate" />
									<px:PXDateTimeEdit ID="edARInvoice__DiscDate" runat="server" DataField="ARInvoice__DiscDate" />
									<px:PXLayoutRule runat="server" ColumnSpan="2" />
                                    <px:PXNumberEdit ID="edAdjdCuryRate" runat="server" CommitChanges="True" DataField="AdjdCuryRate" />
									<px:PXTextEdit ID="edARInvoice__DocDesc1" runat="server" DataField="ARInvoice__DocDesc" />
									<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
									<px:PXNumberEdit ID="edCuryDocBal" runat="server" AllowNull="False" DataField="CuryDocBal" Enabled="False" />
									<px:PXNumberEdit ID="edCuryDiscBal" runat="server" DataField="CuryDiscBal" Enabled="False" />
									<px:PXTextEdit ID="edAdjgRefNbr" runat="server" DataField="AdjgRefNbr" />
									<px:PXTextEdit ID="edAdjdCuryID" runat="server" DataField="AdjdCuryID" />
									<px:PXSelector ID="PXSelector1" runat="server" DataField="WriteOffReasonCode" AutoRefresh="True" />
									<px:PXNumberEdit ID="edAdjNbr" runat="server" DataField="AdjNbr" />
									<px:PXTextEdit ID="edARInvoice__InvoiceNbr" runat="server" DataField="ARInvoice__InvoiceNbr" />
									<px:PXMaskEdit ID="edAdjdFinPeriodID" runat="server" DataField="AdjdFinPeriodID" /></RowTemplate>
								<Columns>
									<px:PXGridColumn DataField="AdjdDocType" Width="117px" RenderEditorText="True" />
									<px:PXGridColumn DataField="AdjdRefNbr" Width="108px" AutoCallBack="True" LinkCommand="ViewDocumentToApply" />
									<px:PXGridColumn DataField="AdjdCustomerID" TextAlign="Right" Width="100px" />
									<px:PXGridColumn AllowNull="False" DataField="CuryAdjgAmt" AutoCallBack="True" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" DataField="CuryAdjgDiscAmt" AutoCallBack="True" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" DataField="CuryAdjgWOAmt" AutoCallBack="True" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" DataField="WriteOffReasonCode" Width="99px" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjdDocDate" Width="90px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__DueDate" Width="90px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__DiscDate" Width="90px" />
                                    <px:PXGridColumn AutoCallBack="True" DataField="AdjdCuryRate" TextAlign="Right" Width="100px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="CuryDocBal" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="CuryDiscBal" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__DocDesc" Width="180px" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjdCuryID" Width="54px" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjdFinPeriodID" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__InvoiceNbr" Width="90px" />
									<px:PXGridColumn DataField="AdjgDocType" Width="18px" />
									<px:PXGridColumn DataField="AdjgRefNbr" Width="90px" />
									<px:PXGridColumn DataField="AdjNbr" TextAlign="Right" Width="54px" />
								</Columns>
							</px:PXGridLevel>
						</Levels>
						<AutoSize Enabled="True" MinHeight="150" />
						<ActionBar>
							<CustomItems>
								<px:PXToolBarButton Text="Load Documents" Tooltip="Load Documents">
								    <AutoCallBack Command="LoadInvoices" Target="ds">
										<Behavior CommitChanges="True" />
									</AutoCallBack>
								</px:PXToolBarButton>
								<px:PXToolBarButton CommandName="ViewDocumentToApply" CommandSourceID="ds" Text="View Document" />
								<px:PXToolBarButton Text="Select Documents" Tooltip="Select Documents">
								    <AutoCallBack Command="SelectInvoices" Target="ds">
										<Behavior CommitChanges="True" />
									</AutoCallBack>
								</px:PXToolBarButton>
							</CustomItems>
						</ActionBar>
					</px:PXGrid>
				</Template>
			</px:PXTabItem>
			<px:PXTabItem Text="Application History">
				<Template>
					<px:PXGrid ID="detgrid2" runat="server" Style="z-index: 100;" Width="100%" Height="300px" SkinID="DetailsInTab" AdjustPageSize="Auto" AllowPaging="True">
						<Levels>
							<px:PXGridLevel DataMember="Adjustments_History">
								<Mode AllowAddNew="False" AllowDelete="False" AllowUpdate="False" />
								<RowTemplate>
									<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
									<px:PXTextEdit ID="edAdjBatchNbr" runat="server" DataField="AdjBatchNbr" Enabled="False" />
									<px:PXDateTimeEdit ID="edAdjdDocDate1" runat="server" DataField="AdjdDocDate" Enabled="False" />
									<px:PXDropDown ID="edAdjdDocType1" runat="server" AllowNull="False" DataField="HistoryAdjdDocType" />
									<px:PXDateTimeEdit ID="edARInvoice__DueDate1" runat="server" DataField="ARInvoice__DueDate" />
									<px:PXSelector ID="edAdjdRefNbr1" runat="server" DataField="AdjdRefNbr" />
									<px:PXDateTimeEdit ID="edARInvoice__DiscDate1" runat="server" DataField="ARInvoice__DiscDate" />
									<px:PXNumberEdit ID="edCuryAdjgAmt1" runat="server" AllowNull="False" DataField="CuryAdjgAmt" />
									<px:PXNumberEdit ID="edCuryDocBal1" runat="server" AllowNull="False" DataField="CuryDocBal" Enabled="False" />
									<px:PXNumberEdit ID="edCuryAdjgDiscAmt1" runat="server" AllowNull="False" DataField="CuryAdjgDiscAmt" />
									<px:PXNumberEdit ID="edCuryDiscBal1" runat="server" DataField="CuryDiscBal" Enabled="False" />
									<px:PXTextEdit ID="edARInvoice__DocDesc" runat="server" DataField="ARInvoice__DocDesc" />
								</RowTemplate>
								<Columns>
									<px:PXGridColumn DataField="AdjBatchNbr" Width="90px" AllowUpdate="False" LinkCommand="ViewCurrentBatch" />
									<px:PXGridColumn DataField="HistoryAdjdDocType" Width="117px" RenderEditorText="True" />
									<px:PXGridColumn DataField="AdjdRefNbr" Width="108px" LinkCommand="ViewApplicationDocument" />
									<px:PXGridColumn DataField="AdjdCustomerID" TextAlign="Right" Width="100px" />
									<px:PXGridColumn AllowNull="False" DataField="CuryAdjgAmt" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" DataField="CuryAdjgDiscAmt" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" DataField="CuryAdjgWOAmt" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjgFinPeriodID" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjdDocDate" Width="90px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__DueDate" Width="90px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__DiscDate" Width="90px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="CuryDocBal" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="CuryDiscBal" TextAlign="Right" Width="81px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__DocDesc" Width="180px" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjdCuryID" Width="54px" />
									<px:PXGridColumn AllowUpdate="False" DataField="AdjdFinPeriodID" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="ARInvoice__InvoiceNbr" Width="90px" />
									<px:PXGridColumn DataField="AdjgDocType" Width="18px" />
									<px:PXGridColumn DataField="AdjgRefNbr" Width="90px" />
									<px:PXGridColumn DataField="AdjNbr" TextAlign="Right" Width="54px" />
								</Columns>
							</px:PXGridLevel>
						</Levels>
						<AutoSize Enabled="True" MinHeight="150" />
						<ActionBar>
							<CustomItems>
								<px:PXToolBarButton Text="View Batch" Tooltip="View Batch" CommandName="ViewCurrentBatch" CommandSourceID="ds" />
							    <px:PXToolBarButton Text="Reverse Application" Tooltip="Reverse Application">
							        <AutoCallBack Command="ReverseApplication" Target="ds">
										<Behavior CommitChanges="True" />
									</AutoCallBack>
								</px:PXToolBarButton>
								<px:PXToolBarButton Text="View Application Document" Tooltip="View Application Document" CommandName="ViewApplicationDocument" CommandSourceID="ds" />
							</CustomItems>
						</ActionBar>
						<Mode AllowFormEdit="True" />
					</px:PXGrid>
				</Template>
			</px:PXTabItem>
            <px:PXTabItem Text="Orders to Apply">
                <Template>
                    <px:PXGrid ID="detgrid3" runat="server" DataSourceID="ds" Style="z-index: 100; left: 0px; top: 0px; height: 382px;" Width="100%"
                        BorderWidth="0px" SkinID="Details" AdjustPageSize="Auto" AllowPaging="True">
                        <Levels>
                            <px:PXGridLevel DataMember="SOAdjustments">
                                <RowTemplate>
                                    <px:PXLayoutRule ID="PXLayoutRule1" runat="server" StartColumn="True" LabelsWidth="M" ControlSize="XM" />
                                    <px:PXSelector ID="edSOAdjdOrderType" runat="server" DataField="AdjdOrderType" AutoRefresh="true" />
                                    <px:PXSelector CommitChanges="True" ID="edSOAdjdOrderNbr" runat="server" DataField="AdjdOrderNbr" AutoRefresh="true">
                                        <Parameters>
                                            <px:PXControlParam ControlID="detgrid3" Name="SOAdjust.adjdOrderType" PropertyName="DataValues[&quot;AdjdOrderType&quot;]" />
                                        </Parameters>
                                    </px:PXSelector>
                                    <px:PXTextEdit ID="edSOSOOrder__Status" runat="server" DataField="SOOrder__Status" Enabled="False"/>
                                    <px:PXNumberEdit ID="edSOCuryAdjgAmt" runat="server" DataField="CuryAdjgAmt" />
                                    <px:PXNumberEdit ID="edSOCuryAdjgBilledAmt" runat="server" DataField="CuryAdjgBilledAmt" />
                                    <px:PXDateTimeEdit ID="edSOAdjdOrderDate" runat="server" DataField="AdjdOrderDate" Enabled="False" />
                                    <px:PXDateTimeEdit ID="edSOSOOrder__DueDate" runat="server" DataField="SOOrder__DueDate" />
                                    <px:PXDateTimeEdit ID="edSOSOOrder__DiscDate" runat="server" DataField="SOOrder__DiscDate" />
                                    <px:PXLayoutRule ID="PXLayoutRule2" runat="server" ColumnSpan="2" />
                                    <px:PXTextEdit ID="edSOSOOrder__OrderDesc" runat="server" DataField="SOOrder__OrderDesc" />
                                    <px:PXLayoutRule ID="PXLayoutRule3" runat="server" StartColumn="True" LabelsWidth="M" ControlSize="XM" />
                                    <px:PXNumberEdit ID="edSOCuryDocBal" runat="server" DataField="CuryDocBal" Enabled="False" />
                                    <px:PXNumberEdit ID="edSOOrder__CuryOrderTotal" runat="server" DataField="SOOrder__CuryOrderTotal" Enabled="False" />
                                    <px:PXTextEdit ID="edSOOrder__CuryID" runat="server" DataField="SOOrder__CuryID" />
                                    <px:PXMaskEdit ID="edSOSOOrder__InvoiceNbr" runat="server" DataField="SOOrder__InvoiceNbr" InputMask="&gt;CCCCCCCCCCCCCCC" />
                                    <px:PXDateTimeEdit ID="edSOSOOrder__InvoiceDate" runat="server" DataField="SOOrder__InvoiceDate" />
                                </RowTemplate>
                                <Columns>
                                    <px:PXGridColumn DataField="AdjdOrderType" Label="Order Type" RenderEditorText="True" />
                                    <px:PXGridColumn DataField="AdjdOrderNbr" Label="Order Nbr." AutoCallBack="True" LinkCommand="ViewSODocumentToApply" />
                                    <px:PXGridColumn DataField="SOOrder__Status" Label="Status" Width="90px" />
                                    <px:PXGridColumn AllowUpdate="False" DataField="AdjgDocType" Label="Doc. Type" RenderEditorText="True" Visible="False" />
                                    <px:PXGridColumn AllowUpdate="False" DataField="AdjgRefNbr" DisplayFormat="&gt;aaaaaaaaaaaaaaa" Label="Reference Nbr." Visible="False" />
                                    <px:PXGridColumn AllowNull="False" DataField="CuryAdjgAmt" Label="Applied To Order" TextAlign="Right" Width="100px" />
                                    <px:PXGridColumn AllowNull="False" DataField="CuryAdjgBilledAmt" Label="Transferred to Invoice" TextAlign="Right" Width="100px" />
                                    <px:PXGridColumn AllowUpdate="False" DataField="AdjdOrderDate" Label="Date" Width="90px" />
                                    <px:PXGridColumn DataField="SOOrder__DueDate" Label="Due Date" Width="90px" />
                                    <px:PXGridColumn DataField="SOOrder__DiscDate" Label="Cash Discount Date" Width="90px" />
                                    <px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="CuryDocBal" Label="Balance" TextAlign="Right" Width="100px" />
                                    <px:PXGridColumn DataField="SOOrder__OrderDesc" Label="Sales Order-Description" Width="200px" />
									<px:PXGridColumn AllowNull="False" AllowUpdate="False" DataField="SOOrder__CuryOrderTotal" Label="Amount" TextAlign="Right" Width="100px" />
                                    <px:PXGridColumn DataField="SOOrder__CuryID" Label="Currency" />
                                    <px:PXGridColumn DataField="SOOrder__InvoiceNbr" DisplayFormat="&gt;CCCCCCCCCCCCCCC" Label="Invoice Nbr." />
                                    <px:PXGridColumn DataField="SOOrder__InvoiceDate" Label="Invoice Date" Width="90px" />
                                </Columns>
                            </px:PXGridLevel>
                        </Levels>
                        <AutoSize Enabled="True" MinHeight="150" />
                        <ActionBar>
                            <CustomItems>
                                <px:PXToolBarButton Text="Load Documents" Tooltip="Load Documents">
                                    <AutoCallBack Command="LoadOrders" Target="ds">
                                        <Behavior CommitChanges="True" />
                                    </AutoCallBack>
                                </px:PXToolBarButton>
                                <px:PXToolBarButton CommandName="ViewSODocumentToApply" CommandSourceID="ds"/>
                            </CustomItems>
                        </ActionBar>
                    </px:PXGrid>
                </Template>
            </px:PXTabItem>
			<px:PXTabItem Text="Financial Details">
				<Template>
					<px:PXFormView ID="form2" runat="server" Style="z-index: 100" Width="100%" DataMember="CurrentDocument" CaptionVisible="False" SkinID="Transparent">
						<Template>
							<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
							<px:PXLayoutRule runat="server" StartGroup="true" GroupCaption="Link to GL"></px:PXLayoutRule>
							<px:PXSelector ID="edBatchNbr" runat="server" DataField="BatchNbr" Enabled="False" AllowEdit="True" />
							<px:PXSegmentMask CommitChanges="True" ID="edBranchID" runat="server" DataField="BranchID" />
							<px:PXSegmentMask CommitChanges="True" ID="edARAccountID" runat="server" DataField="ARAccountID" AutoGenerateColumns="true" />
							<px:PXSegmentMask ID="edARSubID" runat="server" DataField="ARSubID" AutoRefresh="true" AutoGenerateColumns="true">
								<Parameters>
									<px:PXControlParam ControlID="form2" Name="ARRegister.aRAccountID" PropertyName="DataControls[&quot;edARAccountID&quot;].Value" />
								</Parameters>
							</px:PXSegmentMask>
                            <px:PXSegmentMask CommitChanges="True" ID="edProjectID" runat="server" DataField="ProjectID" AutoGenerateColumns="true" />
                            <px:PXSegmentMask CommitChanges="True" ID="edTaskID" runat="server" DataField="TaskID" AutoGenerateColumns="true" />
							
							<px:PXLayoutRule runat="server" StartGroup="true" GroupCaption="Payment Information" LabelsWidth="SM" ControlSize="M" StartColumn="true"></px:PXLayoutRule>
							<px:PXDateTimeEdit CommitChanges="True" ID="edDocDate" runat="server" DataField="DocDate" />
							<px:PXSelector CommitChanges="True" ID="edFinPeriodID" runat="server" DataField="FinPeriodID" />
							<px:PXCheckBox CommitChanges="True" ID="edCleared" runat="server" DataField="Cleared" />
							<px:PXDateTimeEdit CommitChanges="True" Size="s" ID="edClearDate" runat="server" DataField="ClearDate" />
							<px:PXCheckBox CommitChanges="True" ID="chkDepositAsBatch" runat="server" DataField="DepositAsBatch" />
							<px:PXCheckBox ID="chkDeposited" runat="server" DataField="Deposited" />
							<px:PXDateTimeEdit ID="edDepositDate" runat="server" DataField="DepositDate" Enabled="False" />
							<px:PXTextEdit ID="edDepositNbr" runat="server" DataField="DepositNbr" />
						</Template>
						<AutoSize Enabled="True" />
					</px:PXFormView>
				</Template>
			</px:PXTabItem>
			<px:PXTabItem Text="Credit Card Processing Info" BindingContext="form" VisibleExp="DataControls[&quot;chkIsCCPayment&quot;].Value = 1">
				<Template>
					<px:PXGrid ID="grdCCProcTran" runat="server" Height="120px" Width="100%" BorderWidth="0px" Style="left: 0px; top: 0px;" SkinID="DetailsInTab">
						<ActionBar>
							<Actions>
								<Save Enabled="False" />
								<AddNew Enabled="False" />
								<Delete Enabled="False" />
							</Actions>
						</ActionBar>
						<Levels>
							<px:PXGridLevel DataMember="ccProcTran">
								<Mode AllowAddNew="True" AllowDelete="True" AllowUpdate="True" />
								<RowTemplate>
									<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
									<px:PXNumberEdit ID="edTranNbr" runat="server" DataField="TranNbr" />
									<px:PXDropDown ID="edProcStatus" runat="server" AllowNull="False" DataField="ProcStatus" />
									<px:PXTextEdit ID="edProcessingCenterID" runat="server" AllowNull="False" DataField="ProcessingCenterID" />
									<px:PXDropDown ID="edCVVVerificationStatus" runat="server" DataField="CVVVerificationStatus" />
									<px:PXDropDown ID="edTranType" runat="server" DataField="TranType" />
									<px:PXDropDown ID="edTranStatus" runat="server" AllowNull="False" DataField="TranStatus" />
									<px:PXNumberEdit ID="edAmount" runat="server" AllowNull="False" DataField="Amount" />
									<px:PXNumberEdit ID="edRefTranNbr" runat="server" DataField="RefTranNbr" />
									<px:PXTextEdit ID="PXTextEdit2" runat="server" DataField="PCTranNumber" />
									<px:PXTextEdit ID="PXTextEdit3" runat="server" DataField="AuthNumber" />
									<px:PXTextEdit ID="edPCResponseReasonText" runat="server" DataField="PCResponseReasonText" />
									<px:PXDateTimeEdit ID="edStartTime" runat="server" DataField="StartTime" />
								</RowTemplate>
								<Columns>
									<px:PXGridColumn DataField="TranNbr" TextAlign="Right" Width="54px" />
									<px:PXGridColumn AllowNull="False" DataField="ProcessingCenterID" Width="85px" />
									<px:PXGridColumn DataField="TranType" RenderEditorText="True" Width="140px" />
									<px:PXGridColumn AllowNull="False" DataField="TranStatus" RenderEditorText="True" Width="75px" />
									<px:PXGridColumn AllowNull="False" DataField="Amount" TextAlign="Right" Width="80px" />
									<px:PXGridColumn DataField="RefTranNbr" TextAlign="Right" Width="70px" />
									<px:PXGridColumn DataField="PCTranNumber" Width="90px" />
									<px:PXGridColumn DataField="AuthNumber" Width="75px" />
									<px:PXGridColumn DataField="PCResponseReasonText" Width="240px" />
									<px:PXGridColumn DataField="StartTime" />
									<px:PXGridColumn AllowNull="False" DataField="ProcStatus" RenderEditorText="True" Width="72px" />
									<px:PXGridColumn DataField="CVVVerificationStatus" RenderEditorText="True" Width="171px" />
									<px:PXGridColumn DataField="ErrorSource" Visible="False" />
									<px:PXGridColumn DataField="ErrorText" Visible="False" Width="200px" />
								</Columns>
							</px:PXGridLevel>
						</Levels>
						<AutoSize Enabled="True" MinHeight="50" MinWidth="50" />
					</px:PXGrid>
				</Template>
			</px:PXTabItem>
            <px:PXTabItem Text="Finance Charges">
                <Template>
                    <px:PXGrid ID="PXGrid1" runat="server" Height="300px" SkinID="DetailsInTab" Style="z-index: 100;" TabIndex="30500" Width="100%" >
				        <Levels>
						    <px:PXGridLevel DataMember="PaymentCharges" DataKeyNames="DocType,RefNbr,LineNbr">
							    <RowTemplate>
                                    <px:PXSelector ID="edEntryTypeID" runat="server" AutoRefresh="True" CommitChanges="True" DataField="EntryTypeID"/>
                                    <px:PXSegmentMask ID="edAccountID" runat="server" DataField="AccountID" Enabled="False" AllowEdit="False"/>
									<px:PXSegmentMask ID="edSubID" runat="server" DataField="SubID" Enabled="False"  AllowEdit="False"/>
                                    <px:PXNumberEdit ID="edCuryTranAmt" runat="server" CommitChanges="true" DataField="CuryTranAmt"  />
                                </RowTemplate>
					    		<Columns>
                                    <px:PXGridColumn AutoCallBack="True" DataField="EntryTypeID" Width="100px" />
                                    <px:PXGridColumn DataField="TranDesc" Width="160px" />
                                    <px:PXGridColumn DataField="AccountID" Width="115px" />
                                    <px:PXGridColumn DataField="SubID" Width="130px" />
                                    <px:PXGridColumn DataField="CuryTranAmt" TextAlign="Right" AutoCallBack="True" />
                                </Columns>
                           </px:PXGridLevel>
                       </Levels>
                       <AutoSize Enabled="True" MinHeight="150" />
                    </px:PXGrid>
                </Template>
            </px:PXTabItem>
		</Items>
		<CallbackCommands>
			<Search CommitChanges="True" PostData="Page" />
			<Refresh CommitChanges="True" PostData="Page" />
		</CallbackCommands>
		<AutoSize Container="Window" Enabled="True" MinHeight="180" />
	</px:PXTab>
	<!-- begin customization by joshua -->
	<px:PXSmartPanel id="pnlLoadOpts2" runat="server" key="Adjustments2" loadondemand="true" width="900px" height="500px"
        caption="Document Lookup" captionvisible="true" autocallback-command='Refresh' autocallback-enabled="True" autocallback-target="grid4"
        designview="Content">
        <px:PXFormView ID="PXFormView1" runat="server" Style="z-index: 100;" DataMember="loadOpts" CaptionVisible="False" DefaultControlID="edFromDate" SkinID="Transparent">
			<ContentStyle BorderWidth="0px">
			</ContentStyle>
			<Template>
				<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="180px" ColumnWidth="270" ControlSize="S" />
				<px:PXDateTimeEdit ID="edFromDate"  CommitChanges="True" runat="server" DataField="FromDate" />
				<px:PXSelector ID="edStartRefNbr"  CommitChanges="True" runat="server" DataField="StartRefNbr" />
				<px:PXSelector ID="edStartOrderNbr"  CommitChanges="True" runat="server" DataField="StartOrderNbr" />
				<px:PXNumberEdit ID="edMaxDocs"  CommitChanges="True" runat="server" AllowNull="False" DataField="MaxDocs" />
				<px:PXLayoutRule runat="server"   StartColumn="True" LabelsWidth="160px" ColumnWidth="322" ControlSize="S" />
				<px:PXDateTimeEdit ID="edTillDate"  CommitChanges="True" runat="server" DataField="TillDate" />
				<px:PXSelector ID="edEndRefNbr"  CommitChanges="True" runat="server" DataField="EndRefNbr" AutoRefresh="true" />
				<px:PXSelector ID="edEndOrderNbr"  CommitChanges="True" runat="server" DataField="EndOrderNbr" AutoRefresh="true"/>
				<px:PXDropDown ID="edLoadChildDocuments"  CommitChanges="True" runat="server" DataField="LoadChildDocuments" Size="SM" />
				<px:PXLayoutRule runat="server" StartColumn="True" SuppressLabel="True" ControlSize="M" LabelsWidth="S" StartRow="True" />
				<px:PXGroupBox RenderStyle="Fieldset"  CommitChanges="True" ID="gbOrderBy" runat="server" Caption="Order By" DataField="OrderBy">
					<Template>
						<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
						<px:PXRadioButton ID="rbDueDateRefNbr" runat="server" Text="Due Date, Reference Nbr." Value="DUE" GroupName="gbOrderBy" />
						<px:PXRadioButton ID="rbDocDateRefNbr" runat="server" Text="Doc. Date, Reference Nbr." Value="DOC" GroupName="gbOrderBy" />
						<px:PXRadioButton ID="rbRefNbr" runat="server" Text="Reference Nbr." Value="REF" GroupName="gbOrderBy" />
					</Template>
				</px:PXGroupBox>
				<px:PXGroupBox RenderStyle="Fieldset"   ID="gbSOOrderBy" runat="server" Caption="Order By" DataField="SOOrderBy" CommitChanges="True">
					<Template>
						<px:PXLayoutRule  ID="PXLayoutRule5" runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
						<px:PXRadioButton  CommitChanges="True" ID="rbOrderDateOrderNbr" runat="server" Text="Order Date, Order Nbr." Value="DAT" GroupName="gbSOOrderBy" />
						<px:PXRadioButton  CommitChanges="True" ID="rbOrderNbr" runat="server" Text="Order Nbr." Value="ORD" GroupName="gbSOOrderBy" />
					</Template>
				</px:PXGroupBox>
				
			
			</Template>
		</px:PXFormView>
        <px:PXGrid ID="grid4" runat="server" DataSourceID="ds" Style="border-width: 1px 0px;
            top: 0px; left: 0px; height: 189px;" AutoAdjustColumns="true" Width="100%" SkinID="Inquire"
            AdjustPageSize="Auto" AllowSearch="True" FastFilterID="edInventory"
             BatchUpdate="true" >
            <ClientEvents AfterCellUpdate="UpdateItemSiteCell" ></ClientEvents>            
            <ActionBar PagerVisible="False">
                <PagerSettings Mode="NextPrevFirstLast"></PagerSettings>
            </ActionBar>
            <Levels>
                <px:PXGridLevel  
                    DataMember="Adjustments2">
                    <Mode AllowAddNew="false" AllowDelete="false" ></Mode>
                    <Columns>
                        <px:PXGridColumn CommitChanges="true" AllowNull="False" DataField="Selected" TextAlign="Center" Type="CheckBox" Width="80px" AutoCallBack="true" AllowCheckAll="true" ></px:PXGridColumn>
                        <px:PXGridColumn DataField="DocType" Width="117px" RenderEditorText="True" />
						<px:PXGridColumn DataField="RefNbr" Width="108px" AutoCallBack="True" LinkCommand="ViewDocumentToApply" />
						<px:PXGridColumn DataField="DocDate" AutoCallBack="True" TextAlign="Right" Width="81px" />
						<px:PXGridColumn DataField="FinPeriodID" AutoCallBack="True" TextAlign="Right" Width="81px" />
						<px:PXGridColumn DataField="CustomerID" TextAlign="Right" Width="100px" />
						<px:PXGridColumn DataField ="CuryID" />
						<px:PXGridColumn DataField="CuryOrigDocAmt" AutoCallBack="True" TextAlign="Right" Width="81px" />
						<px:PXGridColumn DataField="CuryDocBal" AutoCallBack="True" TextAlign="Right" Width="81px" />
						<px:PXGridColumn DataField="Status" AutoCallBack="True" TextAlign="Right" Width="81px" />
						<px:PXGridColumn DataField="DueDate" AutoCallBack="True" TextAlign="Right" Width="81px" />
						                
                    </Columns>
                </px:PXGridLevel>
            </Levels>
            <AutoSize Enabled="true" ></AutoSize>
        </px:PXGrid>
        <px:PXPanel ID="PXPanel4" runat="server" SkinID="Buttons">
            <px:PXButton ID="PXButton4" runat="server" Text="Add & Close" DialogResult="OK" ></px:PXButton>
            <px:PXButton ID="PXButton6" runat="server" DialogResult="Cancel" Text="Cancel" ></px:PXButton>
        </px:PXPanel>
    </px:PXSmartPanel>
	<!-- end customization by joshua -->
	<px:PXSmartPanel ID="pnlLoadOpts" runat="server" Style="z-index: 108;" Caption="Load Options" CaptionVisible="True" Key="loadOpts" AutoReload="true" LoadOnDemand="true">
		<px:PXFormView ID="loform" runat="server" Style="z-index: 100;" DataMember="loadOpts" CaptionVisible="False" DefaultControlID="edFromDate" SkinID="Transparent">
			<ContentStyle BorderWidth="0px">
			</ContentStyle>
			<Template>
				<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="180px" ColumnWidth="270" ControlSize="S" />
				<px:PXDateTimeEdit ID="PXDateTimeEdit1" runat="server" DataField="FromDate" />
				<px:PXSelector ID="PXSelector2" runat="server" DataField="StartRefNbr" />
				<px:PXSelector ID="PXSelector3" runat="server" DataField="StartOrderNbr" />
				<px:PXNumberEdit ID="PXNumberEdit1" runat="server" AllowNull="False" DataField="MaxDocs" />
				<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="160px" ColumnWidth="322" ControlSize="S" />
				<px:PXDateTimeEdit ID="PXDateTimeEdit2" runat="server" DataField="TillDate" />
				<px:PXSelector ID="PXSelector4" runat="server" DataField="EndRefNbr" AutoRefresh="true" />
				<px:PXSelector ID="PXSelector5" runat="server" DataField="EndOrderNbr" AutoRefresh="true"/>
				<px:PXDropDown ID="PXDropDown1" runat="server" DataField="LoadChildDocuments" Size="SM" />
				<px:PXLayoutRule runat="server" StartColumn="True" SuppressLabel="True" ControlSize="M" LabelsWidth="S" StartRow="True" />
				<px:PXGroupBox RenderStyle="Fieldset" ID="PXGroupBox1" runat="server" Caption="Order By" DataField="OrderBy">
					<Template>
						<px:PXLayoutRule runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
						<px:PXRadioButton ID="PXRadioButton1" runat="server" Text="Due Date, Reference Nbr." Value="DUE" GroupName="gbOrderBy" />
						<px:PXRadioButton ID="PXRadioButton2" runat="server" Text="Doc. Date, Reference Nbr." Value="DOC" GroupName="gbOrderBy" />
						<px:PXRadioButton ID="PXRadioButton3" runat="server" Text="Reference Nbr." Value="REF" GroupName="gbOrderBy" />
					</Template>
				</px:PXGroupBox>
				<px:PXGroupBox RenderStyle="Fieldset" ID="PXGroupBox2" runat="server" Caption="Order By" DataField="SOOrderBy">
					<Template>
						<px:PXLayoutRule ID="PXLayoutRule6" runat="server" StartColumn="True" LabelsWidth="SM" ControlSize="M" />
						<px:PXRadioButton ID="PXRadioButton4" runat="server" Text="Order Date, Order Nbr." Value="DAT" GroupName="gbSOOrderBy" />
						<px:PXRadioButton ID="PXRadioButton5" runat="server" Text="Order Nbr." Value="ORD" GroupName="gbSOOrderBy" />
					</Template>
				</px:PXGroupBox>
				
				<px:PXPanel ID="PXPanel3" runat="server" SkinID="Buttons">
					<px:PXButton ID="PXButton3" runat="server" DialogResult="OK" Text="Load" />
					<px:PXButton ID="PXButton5" runat="server" DialogResult="Cancel" Text="Cancel" />
				</px:PXPanel>
			</Template>
		</px:PXFormView>
	</px:PXSmartPanel>
</asp:Content>
