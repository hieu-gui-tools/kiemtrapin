Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Lenovo Battery &amp; Power Monitor"
        Height="780" Width="680"
        WindowStartupLocation="CenterScreen"
        Background="#0F172A"
        Foreground="#F8FAFC"
        FontFamily="Segoe UI"
        ResizeMode="CanMinimize">

    <Window.Resources>
        <Style TargetType="TextBlock">
            <Setter Property="Foreground" Value="#F8FAFC"/>
        </Style>
        <Style x:Key="Card" TargetType="Border">
            <Setter Property="Background" Value="#1E293B"/>
            <Setter Property="CornerRadius" Value="14"/>
            <Setter Property="Padding" Value="16"/>
            <Setter Property="Margin" Value="0,0,0,12"/>
            <Setter Property="BorderBrush" Value="#334155"/>
            <Setter Property="BorderThickness" Value="1"/>
        </Style>
        <Style x:Key="ActionButton" TargetType="Button">
            <Setter Property="Background" Value="#2563EB"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="14,8"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="8" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/> <!-- Header -->
            <RowDefinition Height="*"/>    <!-- Content Cards -->
            <RowDefinition Height="Auto"/> <!-- Footer / Actions -->
        </Grid.RowDefinitions>

        <!-- HEADER -->
        <Grid Grid.Row="0" Margin="0,0,0,16">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>
            <StackPanel Grid.Column="0">
                <TextBlock Text="⚡ BATTERY &amp; POWER MONITOR" FontSize="20" FontWeight="Bold" Foreground="#38BDF8"/>
                <TextBlock Text="Lenovo IdeaPad 5 Pro 16ACH6 | AMD Ryzen 5 5600H | GTX 1650" FontSize="12" Foreground="#94A3B8" Margin="0,3,0,0"/>
            </StackPanel>
            <Border Grid.Column="1" Name="BadgeStatus" Background="#065F46" CornerRadius="12" Padding="12,5" VerticalAlignment="Center">
                <TextBlock Name="TxtPowerStatus" Text="ĐANG CẮM AC" FontWeight="Bold" FontSize="11" Foreground="#34D399"/>
            </Border>
        </Grid>

        <!-- SCROLLABLE CARDS -->
        <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
            <StackPanel>

                <!-- CARD 1: LIVE BATTERY STATUS -->
                <Border Style="{StaticResource Card}">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>

                        <Grid Grid.Row="0">
                            <TextBlock Text="MỨC PIN &amp; ĐIỆN ÁP THỰC TẾ" FontSize="12" FontWeight="Bold" Foreground="#94A3B8"/>
                            <TextBlock Name="TxtBatteryPercent" Text="--%" HorizontalAlignment="Right" FontSize="26" FontWeight="Bold" Foreground="#10B981"/>
                        </Grid>

                        <!-- Progress Bar -->
                        <Border Grid.Row="1" Background="#0F172A" CornerRadius="8" Height="16" Margin="0,10,0,10" Padding="2">
                            <ProgressBar Name="ProgBattery" Minimum="0" Maximum="100" Value="0" Height="12" BorderThickness="0" Background="Transparent" Foreground="#10B981"/>
                        </Border>

                        <!-- Live Details Grid -->
                        <Grid Grid.Row="2" Margin="0,4,0,0">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <StackPanel Grid.Column="0">
                                <TextBlock Text="Điện áp pin" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtVoltage" Text="-- V" FontSize="16" FontWeight="SemiBold" Foreground="#38BDF8" Margin="0,2,0,0"/>
                                <TextBlock Text="Điện áp cell 4S" FontSize="10" Foreground="#64748B"/>
                            </StackPanel>

                            <StackPanel Grid.Column="1">
                                <TextBlock Text="Công suất sạc" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtChargeRate" Text="-- W" FontSize="16" FontWeight="SemiBold" Foreground="#F59E0B" Margin="0,2,0,0"/>
                                <TextBlock Name="TxtChargeHint" Text="Ngắt sạc thông minh" FontSize="10" Foreground="#64748B"/>
                            </StackPanel>

                            <StackPanel Grid.Column="2">
                                <TextBlock Text="Dung lượng nạp" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtRemainingCapacity" Text="-- mWh" FontSize="16" FontWeight="SemiBold" Foreground="#F8FAFC" Margin="0,2,0,0"/>
                                <TextBlock Text="Tức thời" FontSize="10" Foreground="#64748B"/>
                            </StackPanel>
                        </Grid>
                    </Grid>
                </Border>

                <!-- CARD 2: BATTERY HEALTH & CYCLES -->
                <Border Style="{StaticResource Card}">
                    <StackPanel>
                        <TextBlock Text="ĐỘ CHAI PIN &amp; TUỔI THỌ (HEALTH REPORT)" FontSize="12" FontWeight="Bold" Foreground="#94A3B8" Margin="0,0,0,12"/>

                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <StackPanel Grid.Column="0" Margin="0,0,8,0">
                                <Border Background="#0F172A" CornerRadius="10" Padding="12">
                                    <StackPanel>
                                        <TextBlock Text="Tỷ lệ sức khỏe pin" FontSize="11" Foreground="#94A3B8"/>
                                        <TextBlock Name="TxtHealth" Text="100% (0% chai)" FontSize="18" FontWeight="Bold" Foreground="#10B981" Margin="0,3,0,0"/>
                                        <TextBlock Text="Dung lượng vượt mức chuẩn" FontSize="10" Foreground="#64748B" Margin="0,2,0,0"/>
                                    </StackPanel>
                                </Border>
                            </StackPanel>

                            <StackPanel Grid.Column="1" Margin="8,0,0,0">
                                <Border Background="#0F172A" CornerRadius="10" Padding="12">
                                    <StackPanel>
                                        <TextBlock Text="Số chu kỳ sạc (Cycles)" FontSize="11" Foreground="#94A3B8"/>
                                        <TextBlock Name="TxtCycles" Text="-- lần" FontSize="18" FontWeight="Bold" Foreground="#38BDF8" Margin="0,3,0,0"/>
                                        <TextBlock Text="Chu kỳ sạc xả tương đương 100%" FontSize="10" Foreground="#64748B" Margin="0,2,0,0"/>
                                    </StackPanel>
                                </Border>
                            </StackPanel>
                        </Grid>

                        <Grid Margin="0,12,0,0">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel Grid.Column="0">
                                <TextBlock Text="Dung lượng thiết kế (Design):" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtDesignCapacity" Text="75,000 mWh (75 Wh)" FontSize="13" FontWeight="SemiBold" Foreground="#E2E8F0"/>
                            </StackPanel>
                            <StackPanel Grid.Column="1">
                                <TextBlock Text="Dung lượng sạc đầy (Full Charge):" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtFullCapacity" Text="76,470 mWh (76.47 Wh)" FontSize="13" FontWeight="SemiBold" Foreground="#E2E8F0"/>
                            </StackPanel>
                        </Grid>
                    </StackPanel>
                </Border>

                <!-- CARD 3: HARDWARE & AC POWER DRAW -->
                <Border Style="{StaticResource Card}">
                    <StackPanel>
                        <TextBlock Text="NGUỒN CẤP TRỰC TIẾP &amp; PHẦN CỨNG" FontSize="12" FontWeight="Bold" Foreground="#94A3B8" Margin="0,0,0,12"/>

                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <StackPanel Grid.Column="0">
                                <TextBlock Text="Điện áp củ sạc (AC)" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Text="20.0 V" FontSize="16" FontWeight="SemiBold" Foreground="#F59E0B" Margin="0,2,0,0"/>
                                <TextBlock Text="Chuẩn nguồn Lenovo" FontSize="10" Foreground="#64748B"/>
                            </StackPanel>

                            <StackPanel Grid.Column="1">
                                <TextBlock Text="Công suất GPU (GTX 1650)" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtGpuPower" Text="-- W" FontSize="16" FontWeight="SemiBold" Foreground="#38BDF8" Margin="0,2,0,0"/>
                                <TextBlock Text="NVIDIA Telemetry" FontSize="10" Foreground="#64748B"/>
                            </StackPanel>

                            <StackPanel Grid.Column="2">
                                <TextBlock Text="Ước tính AC tổng" FontSize="11" Foreground="#94A3B8"/>
                                <TextBlock Name="TxtTotalEstimate" Text="35 - 55 W" FontSize="16" FontWeight="SemiBold" Foreground="#A855F7" Margin="0,2,0,0"/>
                                <TextBlock Text="CPU + GPU + Màn hình" FontSize="10" Foreground="#64748B"/>
                            </StackPanel>
                        </Grid>

                        <Border Background="#0F172A" CornerRadius="8" Padding="10" Margin="0,12,0,0">
                            <TextBlock Name="TxtAdvisory" Text="💡 Máy đang cắm AC và ngắt sạc pin thông minh để tránh chai pin." FontSize="11" Foreground="#CBD5E1" TextWrapping="Wrap"/>
                        </Border>
                    </StackPanel>
                </Border>

            </StackPanel>
        </ScrollViewer>

        <!-- FOOTER / ACTION BUTTONS -->
        <Grid Grid.Row="2" Margin="0,10,0,0">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>

            <StackPanel Grid.Column="0" VerticalAlignment="Center">
                <TextBlock Name="TxtLastUpdate" Text="Cập nhật: --:--:--" FontSize="11" Foreground="#64748B"/>
            </StackPanel>

            <Button Grid.Column="1" Name="BtnReport" Content="📄 Xem Báo Cáo Pin Chi Tiết" Style="{StaticResource ActionButton}" Background="#334155" Margin="0,0,8,0"/>
            <Button Grid.Column="2" Name="BtnRefresh" Content="🔄 Làm mới ngay" Style="{StaticResource ActionButton}"/>
        </Grid>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# Get Controls
$TxtPowerStatus       = $window.FindName("TxtPowerStatus")
$BadgeStatus          = $window.FindName("BadgeStatus")
$TxtBatteryPercent    = $window.FindName("TxtBatteryPercent")
$ProgBattery          = $window.FindName("ProgBattery")
$TxtVoltage           = $window.FindName("TxtVoltage")
$TxtChargeRate        = $window.FindName("TxtChargeRate")
$TxtChargeHint        = $window.FindName("TxtChargeHint")
$TxtRemainingCapacity = $window.FindName("TxtRemainingCapacity")
$TxtHealth            = $window.FindName("TxtHealth")
$TxtCycles            = $window.FindName("TxtCycles")
$TxtDesignCapacity    = $window.FindName("TxtDesignCapacity")
$TxtFullCapacity      = $window.FindName("TxtFullCapacity")
$TxtGpuPower          = $window.FindName("TxtGpuPower")
$TxtTotalEstimate     = $window.FindName("TxtTotalEstimate")
$TxtAdvisory          = $window.FindName("TxtAdvisory")
$TxtLastUpdate        = $window.FindName("TxtLastUpdate")
$BtnReport            = $window.FindName("BtnReport")
$BtnRefresh           = $window.FindName("BtnRefresh")

# Function to read static battery stats
function Get-StaticBatteryInfo {
    try {
        $reportPath = Join-Path $PSScriptRoot "battery-report.html"
        if (-not (Test-Path $reportPath)) {
            powercfg /batteryreport /output $reportPath | Out-Null
        }
        
        $content = Get-Content $reportPath -Raw
        $design = 75000
        $full = 76470
        $cycles = 176

        if ($content -match 'DESIGN CAPACITY</td>\s*<td[^>]*>([0-9, ]+)\s*mWh') {
            $design = [int]($Matches[1].Replace(',', '').Trim())
        }
        if ($content -match 'FULL CHARGE CAPACITY</td>\s*<td[^>]*>([0-9, ]+)\s*mWh') {
            $full = [int]($Matches[1].Replace(',', '').Trim())
        }
        if ($content -match 'CYCLE COUNT</td>\s*<td[^>]*>([0-9, ]+)</td>') {
            $cycles = [int]($Matches[1].Replace(',', '').Trim())
        }

        $healthPct = [math]::Round(($full / $design) * 100, 1)
        return @{
            DesignCapacity = $design
            FullCapacity   = $full
            Cycles         = $cycles
            HealthPct      = $healthPct
        }
    } catch {
        return @{
            DesignCapacity = 75000
            FullCapacity   = 76470
            Cycles         = 176
            HealthPct      = 101.9
        }
    }
}

$staticInfo = Get-StaticBatteryInfo
$TxtDesignCapacity.Text = "{0:N0} mWh ({1} Wh)" -f $staticInfo.DesignCapacity, ($staticInfo.DesignCapacity / 1000)
$TxtFullCapacity.Text   = "{0:N0} mWh ({1:N2} Wh)" -f $staticInfo.FullCapacity, ($staticInfo.FullCapacity / 1000)
$TxtCycles.Text         = "{0} lần" -f $staticInfo.Cycles

if ($staticInfo.HealthPct -ge 100) {
    $TxtHealth.Text = ("{0}% (0% chai)" -f $staticInfo.HealthPct)
    $TxtHealth.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#10B981")
} else {
    $wear = 100 - $staticInfo.HealthPct
    $TxtHealth.Text = ("{0}% (Chai {1}%)" -f $staticInfo.HealthPct, $wear)
    if ($wear -gt 20) {
        $TxtHealth.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#EF4444")
    } else {
        $TxtHealth.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#F59E0B")
    }
}

# Function to refresh live data
function Update-Sensors {
    try {
        $bat = Get-CimInstance -Namespace root\wmi -ClassName BatteryStatus -ErrorAction SilentlyContinue
        $winBat = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue

        if ($bat) {
            $voltageV = [math]::Round($bat.Voltage / 1000.0, 3)
            $TxtVoltage.Text = "$voltageV V"

            $chargeRateW = [math]::Round($bat.ChargeRate / 1000.0, 2)
            $dischargeRateW = [math]::Round($bat.DischargeRate / 1000.0, 2)
            $remainingMwh = $bat.RemainingCapacity
            $TxtRemainingCapacity.Text = "{0:N0} mWh" -f $remainingMwh

            # Estimate Battery Percent
            $percent = 95
            if ($winBat -and $winBat.EstimatedChargeRemaining) {
                $percent = $winBat.EstimatedChargeRemaining
            } elseif ($staticInfo.FullCapacity -gt 0) {
                $percent = [math]::Min(100, [math]::Round(($remainingMwh / $staticInfo.FullCapacity) * 100))
            }
            $TxtBatteryPercent.Text = "$percent%"
            $ProgBattery.Value = $percent

            # AC and Charging State
            if ($bat.PowerOnline) {
                if ($chargeRateW -gt 0.5) {
                    $TxtPowerStatus.Text = "ĐANG CẮM AC (ĐANG SẠC)"
                    $BadgeStatus.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#1E3A8A") # Blue
                    $TxtPowerStatus.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#60A5FA")
                    $TxtChargeRate.Text = "+$chargeRateW W"
                    $TxtChargeRate.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#10B981")
                    $TxtChargeHint.Text = "Đang nạp điện vào pin"
                    $TxtAdvisory.Text = "⚡ Pin đang được nạp điện với công suất $chargeRateW W."
                } else {
                    $TxtPowerStatus.Text = "ĐANG CẮM AC (DÙNG TRỰC TIẾP)"
                    $BadgeStatus.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#065F46") # Green
                    $TxtPowerStatus.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#34D399")
                    $TxtChargeRate.Text = "0.00 W"
                    $TxtChargeRate.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#94A3B8")
                    $TxtChargeHint.Text = "Ngắt sạc thông minh (Bảo vệ pin)"
                    $TxtAdvisory.Text = "🛡️ Máy đang dùng điện trực tiếp từ củ sạc AC. Mạch sạc ngắt để bảo vệ tuổi thọ pin."
                }
            } else {
                $TxtPowerStatus.Text = "ĐANG DÙNG PIN (DC)"
                $BadgeStatus.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#7C2D12") # Amber
                $TxtPowerStatus.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#FDBA74")
                $TxtChargeRate.Text = "-$dischargeRateW W"
                $TxtChargeRate.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#F87171")
                $TxtChargeHint.Text = "Công suất đang xả"
                $TxtAdvisory.Text = "🔋 Laptop đang chạy bằng pin. Công suất tiêu thụ pin hiện tại là $dischargeRateW W."
            }
        }

        # GPU Power Draw via nvidia-smi
        $gpuPower = & nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits 2>$null
        if ($gpuPower) {
            $gpuW = [math]::Round([double]$gpuPower, 1)
            $TxtGpuPower.Text = "$gpuW W"
            if ($gpuW -gt 30) {
                $TxtTotalEstimate.Text = "{0:N0} - {1:N0} W" -f ($gpuW + 25), ($gpuW + 55)
            } else {
                $TxtTotalEstimate.Text = "35 - 55 W"
            }
        } else {
            $TxtGpuPower.Text = "Sleep / 0 W"
        }

        $TxtLastUpdate.Text = "Cập nhật: " + (Get-Date -Format "HH:mm:ss")
    } catch {
        $TxtLastUpdate.Text = "Lỗi đọc cảm biến: " + $_.Exception.Message
    }
}

# Initial Run
Update-Sensors

# Timer for live updates (Every 1.5 seconds)
$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(1.5)
$timer.Add_Tick({ Update-Sensors })
$timer.Start()

# Button Events
$BtnRefresh.Add_Click({ Update-Sensors })
$BtnReport.Add_Click({
    $reportPath = Join-Path $PSScriptRoot "battery-report.html"
    if (-not (Test-Path $reportPath)) {
        powercfg /batteryreport /output $reportPath | Out-Null
    }
    Start-Process $reportPath
})

$window.Add_Closed({
    if ($timer) { $timer.Stop() }
})

[void]$window.ShowDialog()
