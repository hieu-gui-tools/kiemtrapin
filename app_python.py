# -*- coding: utf-8 -*-
"""
Battery & Power Monitor GUI (Python Tkinter Version)
Yêu cầu thư viện: pip install wmi
"""

import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import os
import sys

try:
    import wmi
except ImportError:
    wmi = None


class BatteryMonitorApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Lenovo Battery & Power Monitor")
        self.geometry("560x650")
        self.configure(bg="#0F172A")
        self.resizable(False, False)

        self.wmi_w = None
        if wmi:
            try:
                self.wmi_w = wmi.WMI(namespace="root\\wmi")
            except Exception:
                self.wmi_w = None

        self.create_widgets()
        self.update_telemetry()

    def create_widgets(self):
        # Header
        header_frame = tk.Frame(self, bg="#0F172A")
        header_frame.pack(fill="x", padx=20, pady=(15, 10))

        title_lbl = tk.Label(
            header_frame,
            text="⚡ BATTERY & POWER MONITOR",
            font=("Segoe UI", 16, "bold"),
            fg="#38BDF8",
            bg="#0F172A",
        )
        title_lbl.pack(anchor="w")

        sub_lbl = tk.Label(
            header_frame,
            text="Lenovo IdeaPad 5 Pro 16ACH6 | AMD Ryzen 5 5600H | GTX 1650",
            font=("Segoe UI", 9),
            fg="#94A3B8",
            bg="#0F172A",
        )
        sub_lbl.pack(anchor="w", pady=(2, 0))

        # Card 1: Battery & Voltage
        card1 = tk.LabelFrame(
            self,
            text=" [1] MỨC PIN & ĐIỆN ÁP THỰC TẾ ",
            font=("Segoe UI", 10, "bold"),
            fg="#94A3B8",
            bg="#1E293B",
            padx=15,
            pady=12,
        )
        card1.pack(fill="x", padx=20, pady=6)

        self.lbl_percent = tk.Label(
            card1,
            text="--%",
            font=("Segoe UI", 24, "bold"),
            fg="#10B981",
            bg="#1E293B",
        )
        self.lbl_percent.pack(anchor="w")

        self.lbl_voltage = tk.Label(
            card1,
            text="Điện áp pin: Đang đọc...",
            font=("Segoe UI", 11),
            fg="#F8FAFC",
            bg="#1E293B",
        )
        self.lbl_voltage.pack(anchor="w", pady=2)

        self.lbl_chargerate = tk.Label(
            card1,
            text="Công suất sạc: Đang đọc...",
            font=("Segoe UI", 11),
            fg="#F59E0B",
            bg="#1E293B",
        )
        self.lbl_chargerate.pack(anchor="w", pady=2)

        # Card 2: Health
        card2 = tk.LabelFrame(
            self,
            text=" [2] ĐỘ CHAI PIN & TUỔI THỌ ",
            font=("Segoe UI", 10, "bold"),
            fg="#94A3B8",
            bg="#1E293B",
            padx=15,
            pady=12,
        )
        card2.pack(fill="x", padx=20, pady=6)

        health_lbl = tk.Label(
            card2,
            text="Sức khỏe pin: 100% (0% chai) - Vượt mức thiết kế",
            font=("Segoe UI", 11, "bold"),
            fg="#10B981",
            bg="#1E293B",
        )
        health_lbl.pack(anchor="w")

        details_lbl = tk.Label(
            card2,
            text="Thiết kế: 75,000 mWh | Sạc đầy: 76,470 mWh | Chu kỳ: 176 lần",
            font=("Segoe UI", 10),
            fg="#CBD5E1",
            bg="#1E293B",
        )
        details_lbl.pack(anchor="w", pady=4)

        # Card 3: Hardware Draw
        card3 = tk.LabelFrame(
            self,
            text=" [3] NGUỒN CẤP TRỰC TIẾP & PHẦN CỨNG ",
            font=("Segoe UI", 10, "bold"),
            fg="#94A3B8",
            bg="#1E293B",
            padx=15,
            pady=12,
        )
        card3.pack(fill="x", padx=20, pady=6)

        ac_lbl = tk.Label(
            card3,
            text="Điện áp củ sạc AC: 20.0 V DC (Tiêu chuẩn Lenovo)",
            font=("Segoe UI", 10),
            fg="#CBD5E1",
            bg="#1E293B",
        )
        ac_lbl.pack(anchor="w")

        self.lbl_gpu = tk.Label(
            card3,
            text="Công suất GPU (GTX 1650): -- W",
            font=("Segoe UI", 10),
            fg="#38BDF8",
            bg="#1E293B",
        )
        self.lbl_gpu.pack(anchor="w", pady=2)

        self.lbl_status = tk.Label(
            card3,
            text="Trạng thái: Đang kết nối nguồn AC (Dùng điện trực tiếp)",
            font=("Segoe UI", 10, "bold"),
            fg="#34D399",
            bg="#1E293B",
        )
        self.lbl_status.pack(anchor="w", pady=4)

        # Buttons
        btn_frame = tk.Frame(self, bg="#0F172A")
        btn_frame.pack(fill="x", padx=20, pady=15)

        btn_report = tk.Button(
            btn_frame,
            text="📄 Xem Báo Cáo Pin Chi Tiết",
            command=self.open_report,
            bg="#334155",
            fg="white",
            relief="flat",
            padx=12,
            pady=6,
        )
        btn_report.pack(side="left")

        btn_refresh = tk.Button(
            btn_frame,
            text="🔄 Làm Mới Ngay",
            command=self.update_telemetry,
            bg="#2563EB",
            fg="white",
            relief="flat",
            padx=12,
            pady=6,
        )
        btn_refresh.pack(side="right")

    def update_telemetry(self):
        try:
            if self.wmi_w:
                status = self.wmi_w.BatteryStatus()[0]
                volt = status.Voltage / 1000.0
                charge_rate = status.ChargeRate / 1000.0
                dischg_rate = status.DischargeRate / 1000.0

                self.lbl_voltage.config(text=f"Điện áp pin: {volt:.3f} V")
                if status.PowerOnline:
                    if charge_rate > 0.5:
                        self.lbl_chargerate.config(
                            text=f"Công suất sạc: +{charge_rate:.2f} W (Đang sạc)"
                        )
                        self.lbl_status.config(
                            text="Trạng thái: Đang cắm sạc (Đang nạp pin)",
                            fg="#60A5FA",
                        )
                    else:
                        self.lbl_chargerate.config(
                            text="Công suất sạc: 0.00 W (Ngắt sạc thông minh)"
                        )
                        self.lbl_status.config(
                            text="Trạng thái: Đang cắm AC (Dùng điện trực tiếp, ngắt sạc bảo vệ)",
                            fg="#34D399",
                        )
                else:
                    self.lbl_chargerate.config(
                        text=f"Công suất xả: -{dischg_rate:.2f} W"
                    )
                    self.lbl_status.config(
                        text="Trạng thái: Đang dùng pin (DC)", fg="#FDBA74"
                    )

            # GPU Draw
            res = subprocess.run(
                [
                    "nvidia-smi",
                    "--query-gpu=power.draw",
                    "--format=csv,noheader,nounits",
                ],
                capture_output=True,
                text=True,
            )
            if res.returncode == 0:
                self.lbl_gpu.config(
                    text=f"Công suất GPU (GTX 1650): {float(res.stdout.strip()):.1f} W"
                )
        except Exception as e:
            pass

        # Schedule next update in 2000 ms
        self.after(2000, self.update_telemetry)

    def open_report(self):
        report_path = os.path.join(
            os.path.dirname(__file__), "battery-report.html"
        )
        if not os.path.exists(report_path):
            subprocess.run(["powercfg", "/batteryreport", "/output", report_path])
        os.system(f'start "" "{report_path}"')


if __name__ == "__main__":
    app = BatteryMonitorApp()
    app.mainloop()
