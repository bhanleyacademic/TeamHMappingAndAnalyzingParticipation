<%@ control language="C#" autoeventwireup="true" inherits="BarChart, App_Web_bar.ascx.cc671b29" %>
<%@ Register TagPrefix="zgw" Namespace="EventGraph.Web" Assembly="EventGraph.Web" %>

<zgw:EventGraphweb id="EventGraphWeb1" runat="server" RenderMode="ImageTag" 
            Width="440" Height="400" BarType="Cluster" TmpImageDuration="50" RenderedImagePath="EventGraphImges">  
            
    <XAxis AxisColor="Black" Cross="0" CrossAuto="True" IsOmitMag="False" IsPreventLabelOverlap="True"
        IsShowTitle="True" IsTicsBetweenLabels="True" IsUseTenPower="False" IsVisible="True"
        IsZeroLine="False" MinSpace="0" Title="" Type="Linear">
        <FontSpec Angle="0" Family="TimesNewRoman" FontColor="Black" IsBold="True" IsItalic="False"
            IsUnderline="False" Size="24" StringAlignment="Center">
            <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
                IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
            <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
        </FontSpec>
        <MinorGrid Color="Black" DashOff="5" DashOn="1" IsVisible="False" PenWidth="1" />
        <MinorTic Color="Black" IsInside="True" IsOpposite="True" IsOutside="True" PenWidth="1"
            Size="5" />
        <MajorTic Color="Black" IsInside="True" IsOpposite="True" IsOutside="True" PenWidth="1"
            Size="5" />
        <Scale Align="Center" Format="g" FormatAuto="False"  IsReverse="False" Mag="0" MagAuto="False"
            MajorStep="1" MajorStepAuto="False" MajorUnit="Day" Max="0" MaxAuto="True" MaxGrace="0.1"
            Min="0" MinAuto="True" MinGrace="0.1" MinorStep="1" MinorStepAuto="True" MinorUnit="Day">
            <FontSpec Angle="90" Family="TimesNewRoman"  FontColor="Black" IsBold="False" IsItalic="False"
                IsUnderline="False" Size="14" StringAlignment="Near" >
                <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
                    IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
                <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
            </FontSpec>
        </Scale>
        <MajorGrid Color="Black" DashOff="5" DashOn="1" IsVisible="False" PenWidth="1" />
    </XAxis>
    <Y2Axis AxisColor="Black" Cross="0" CrossAuto="True" IsOmitMag="False" IsPreventLabelOverlap="True"
        IsShowTitle="True" IsTicsBetweenLabels="True" IsUseTenPower="False" IsVisible="False"
        IsZeroLine="True" MinSpace="0" Title="" Type="Linear">
        <FontSpec Angle="0" Family="TimesNewRoman" FontColor="Black" IsBold="True" IsItalic="False"
            IsUnderline="False" Size="20" StringAlignment="Center">
            <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
                IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
            <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
        </FontSpec>
        <MinorGrid Color="Black" DashOff="5" DashOn="1" IsVisible="False" PenWidth="1" />
        <MinorTic Color="Black" IsInside="True" IsOpposite="True" IsOutside="True" PenWidth="1"
            Size="5" />
        <MajorTic Color="Black" IsInside="True" IsOpposite="True" IsOutside="True" PenWidth="1"
            Size="5" />
        <Scale Align="Center" Format="g" FormatAuto="False"  IsReverse="False" Mag="0" MagAuto="False"
            MajorStep="1" MajorStepAuto="False" MajorUnit="Day" Max="0" MaxAuto="True" MaxGrace="0.1"
            Min="0" MinAuto="True" MinGrace="0.1" MinorStep="1" MinorStepAuto="True" MinorUnit="Day">
            <FontSpec Angle="-90" Family="TimesNewRoman" FontColor="Black" IsBold="False" IsItalic="False"
                IsUnderline="False" Size="20" StringAlignment="Center">
                <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
                    IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
                <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
            </FontSpec>
        </Scale>
        <MajorGrid Color="Black" DashOff="5" DashOn="1" IsVisible="False" PenWidth="1" />
    </Y2Axis>
    <MasterPaneBorder Color="Black" InflateFactor="0" IsVisible="True" Width="1" />
    <MasterPaneFill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100"
        IsScaled="True" IsVisible="True" RangeMax="0" RangeMin="0" Type="Solid" />
    <PaneBorder Color="Black" InflateFactor="0" IsVisible="True" Width="1" />
    <YAxis AxisColor="Black" Cross="0" CrossAuto="True"  IsOmitMag="False" IsPreventLabelOverlap="True"
        IsShowTitle="True" IsTicsBetweenLabels="True" IsUseTenPower="False" IsVisible="True"
        IsZeroLine="True" MinSpace="0" Title="" Type="Linear">
        <FontSpec Angle="-180" Family="TimesNewRoman" FontColor="Black" IsBold="True" IsItalic="False"
            IsUnderline="False" Size="24" StringAlignment="Center">
            <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
                IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
            <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
        </FontSpec>
        <MinorGrid Color="Black" DashOff="5" DashOn="1" IsVisible="False" PenWidth="1" />
        <MinorTic Color="Black" IsInside="True" IsOpposite="True" IsOutside="True" PenWidth="1"
            Size="5" />
        <MajorTic Color="Black" IsInside="True" IsOpposite="True" IsOutside="True" PenWidth="1"
            Size="5" />
        <Scale Align="Center" Format="g" FormatAuto="False"  IsReverse="False" Mag="0" MagAuto="False"
            MajorStep="1" MajorStepAuto="False" MajorUnit="Day" Max="0" MaxAuto="True" MaxGrace="0.1"
            Min="0" MinAuto="True" MinGrace="0.1" MinorStep="1" MinorStepAuto="True" MinorUnit="Day">
            <FontSpec Angle="90" Family="TimesNewRoman" FontColor="Black" IsBold="False" IsItalic="False"
                IsUnderline="False" Size="20" StringAlignment="Center">
                <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True" 
                    IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
                <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
            </FontSpec>
        </Scale>
        <MajorGrid Color="Black" DashOff="5" DashOn="1" IsVisible="False" PenWidth="1" />
    </YAxis>
    <PaneFill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
        IsVisible="True" RangeMax="0" RangeMin="0" Type="Solid" />
    <ChartFill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
        IsVisible="True" RangeMax="0" RangeMin="0" Type="Brush" />
    <ChartBorder Color="Black" InflateFactor="0" IsVisible="True" Width="1" />
    <FontSpec Angle="0" Family="TimesNewRoman" FontColor="Black" IsBold="True" IsItalic="False"
        IsUnderline="False" Size="24" StringAlignment="Center">
        <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
            IsVisible="True" RangeMax="0" RangeMin="0" Type="None" />
        <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
    </FontSpec>
    <Margins Bottom="10" Left="10" Right="10" Top="10" />
    <Legend IsHStack="True" IsReverse="False" IsVisible="True" Position="Top">
        <Location AlignH="Left" AlignV="Center" CoordinateFrame="ChartFraction" Height="0"
            Width="0" X="0" Y="0">
            <TopLeft X="0" Y="0" />
            <BottomRight X="0" Y="0" />
        </Location>
        <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
            IsVisible="True" RangeMax="0" RangeMin="0" Type="Brush" />
        <Border Color="Black" InflateFactor="0" IsVisible="True" Width="1" />
        <FontSpec Angle="0" Family="TimesNewRoman" FontColor="Black" IsBold="False" IsItalic="False"
            IsUnderline="False" Size="20" StringAlignment="Center">
            <Fill AlignH="Center" AlignV="Center" Color="White" ColorOpacity="100" IsScaled="True"
                IsVisible="True" RangeMax="0" RangeMin="0" Type="Solid" />
            <Border Color="Black" InflateFactor="0" IsVisible="False" Width="1" />
        </FontSpec>
    </Legend>
    
</zgw:EventGraphweb>
<asp:Label ID="lmsg" runat="server" Text="Label" 
Style=" position:absolute; Top:466px; left:15px" Width="265px"></asp:Label>      