/// <XRTypeInfo>
///   <AssemblyFullName>DevExpress.XtraReports.v10.2, Version=10.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a</AssemblyFullName>
///   <AssemblyLocation>C:\WINDOWS\assembly\GAC_MSIL\DevExpress.XtraReports.v10.2\10.2.4.0__b88d1754d700e49a\DevExpress.XtraReports.v10.2.dll</AssemblyLocation>
///   <TypeName>DevExpress.XtraReports.UI.XtraReport</TypeName>
///   <Localization>es-ES</Localization>
/// </XRTypeInfo>
namespace XtraReportSerialization {
    
    public class InformeNuevo : DevExpress.XtraReports.UI.XtraReport {
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private System.Resources.ResourceManager _resources;
        public InformeNuevo() {
            this.InitializeComponent();
        }
        private System.Resources.ResourceManager resources {
            get {
                if (_resources == null) {
                    string resourceString = "zsrvvgEAAACRAAAAbFN5c3RlbS5SZXNvdXJjZXMuUmVzb3VyY2VSZWFkZXIsIG1zY29ybGliLCBWZXJza" +
                        "W9uPTIuMC4wLjAsIEN1bHR1cmU9bmV1dHJhbCwgUHVibGljS2V5VG9rZW49Yjc3YTVjNTYxOTM0ZTA4O" +
                        "SNTeXN0ZW0uUmVzb3VyY2VzLlJ1bnRpbWVSZXNvdXJjZVNldAIAAAAAAAAAAAAAAFBBRFBBRFC0AAAA";
                    this._resources = new DevExpress.XtraReports.Serialization.XRResourceManager(resourceString);
                }
                return this._resources;
            }
        }
        private void InitializeComponent() {
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // TopMargin
            // 
            this.TopMargin.Name = "TopMargin";
            // 
            // Detail
            // 
            this.Detail.Name = "Detail";
            // 
            // BottomMargin
            // 
            this.BottomMargin.Name = "BottomMargin";
            // 
            // InformeNuevo
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
                        this.TopMargin,
                        this.Detail,
                        this.BottomMargin});
            this.Name = "InformeNuevo";
            this.PageHeight = 1100;
            this.PageWidth = 850;
            this.Version = "10.2";
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();
        }
    }
}