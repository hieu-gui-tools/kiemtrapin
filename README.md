# ⚡ Lenovo Battery & Power Monitor (Kiểm Tra Pin & Quản Lý Nguồn Điện)

Bộ công cụ giám sát pin, phân tích sức khỏe nguồn điện và khắc phục triệt để các lỗi treo máy, hao pin khi Sleep / Fast Startup dành cho laptop Windows (đặc biệt tối ưu cho dòng máy Lenovo IdeaPad / ThinkPad / Legion).

---

## 🌟 Tính Năng Nổi Bật

1. **Giám Sát Viễn Đo Đo Tức Thời (Real-time Telemetry):**
   - Đọc trực tiếp cảm biến WMI/CIM: Mức pin hiện tại (%), Trạng thái sạc/xả, Điện áp pin thực tế (V/mV).
   - Đo công suất sạc và xả tức thời (W/mW).
   - Kiểm tra dung lượng thiết kế (**Design Capacity**) so với dung lượng sạc đầy thực tế (**Full Charge Capacity**).
   - Tự động tính toán tỷ lệ hao mòn / chai pin (**Wear Level**) và số chu kỳ sạc (**Cycle Count**).

2. **Giao Diện Kép Linh Hoạt (PowerShell WPF & Python Tkinter):**
   - **`BatteryMonitor.ps1`:** Giao diện WPF hiện đại chuẩn phong cách Dark Slate (`#0F172A`), chạy trực tiếp trên Windows PowerShell không cần cài đặt thêm bất kỳ thư viện bên thứ ba nào.
   - **`app_python.py`:** Phiên bản GUI viết bằng Python (Tkinter + WMI), dễ dàng tùy biến hoặc tích hợp vào các dự án Python.
   - **`Run-Monitor.bat`:** Khởi động nhanh bản PowerShell ẩn console chỉ với một click.

3. **Chẩn Đoán Nguồn Điện Sâu (Deep Power Diagnostics):**
   - **`diagnose.ps1`:** Tự động kiểm tra các trạng thái nguồn khả dụng (`powercfg /a`), truy vấn chi tiết nhật ký sự kiện **Kernel-Power (Event ID 41)** để xác định nguyên nhân sập nguồn đột ngột hoặc cưỡng bức tắt nguồn.
   - Kiểm tra các bản ghi lỗi bộ nhớ **Minidump** (`C:\Windows\Minidump`).

4. **Khắc Phục Lỗi Nguồn Triệt Để (Fix-PowerIssues.bat):**
   - Bật chế độ Hibernate chuẩn an toàn (`powercfg /h on`).
   - Tắt tính năng Fast Startup (thủ phạm chính gây kẹt nguồn, treo máy khi tắt/bật lại trên laptop Windows 10/11).
   - Khóa tắt điện ổ cứng SSD (Disk Timeout = Never).
   - Tắt cơ chế ngắt điện PCIe Link State Power Management (ngăn chặn mất kết nối ổ cứng SSD NVMe khi chuyển trạng thái nghỉ).

---

## 📂 Cấu Trúc Dự Án

```
kiemtrapin/
├── BatteryMonitor.ps1    # Giao diện WPF PowerShell theo dõi pin & nguồn điện
├── Run-Monitor.bat       # Phím tắt chạy ngầm BatteryMonitor.ps1 không hiện cửa sổ console
├── app_python.py         # Phiên bản ứng dụng GUI bằng Python Tkinter
├── Fix-PowerIssues.bat   # Script tự động sửa lỗi sập nguồn/treo Sleep/Fast Startup (Run as Admin)
├── diagnose.ps1          # Script chẩn đoán lỗi Kernel-Power 41 & trạng thái nguồn
└── .gitignore            # Loại bỏ các file tạm, báo cáo HTML và cache
```

---

## 🚀 Hướng Dẫn Sử Dụng

### Cách 1: Sử dụng Bản PowerShell WPF (Khuyên dùng - Không cần cài đặt)

Chỉ cần click đúp vào file:
```cmd
Run-Monitor.bat
```
hoặc mở PowerShell và chạy:
```powershell
powershell -ExecutionPolicy Bypass -File .\BatteryMonitor.ps1
```

### Cách 2: Sử dụng Bản Python GUI

Yêu cầu môi trường Python 3.8+ trên Windows:

```bash
# 1. Cài đặt thư viện WMI
pip install wmi

# 2. Khởi chạy ứng dụng
python app_python.py
```

### Cách 3: Sửa lỗi treo nguồn / không bật được máy khi Sleep

Nếu máy tính của bạn bị hiện tượng quạt quay nhưng màn hình không lên sau khi gập máy hoặc Sleep:
1. Nhấp chuột phải vào file **`Fix-PowerIssues.bat`**.
2. Chọn **Run as administrator** (Chạy với quyền Quản trị viên).
3. Đợi script tự động tối ưu hóa trong vài giây và khởi động lại máy để áp dụng.

### Cách 4: Chẩn đoán sự cố sập nguồn đột ngột (Kernel-Power Event 41)

Chạy file script chẩn đoán trong PowerShell:
```powershell
powershell -ExecutionPolicy Bypass -File .\diagnose.ps1
```

---

## 📋 Yêu Cầu Hệ Thống

- **Hệ điều hành:** Windows 10 hoặc Windows 11 (64-bit).
- **Quyền:** Khuyến khích quyền Administrator đối với các tính năng sửa nguồn hoặc xuất báo cáo hệ thống.
- **Python (tùy chọn):** Phiên bản 3.8 trở lên nếu chạy `app_python.py`.

---

## 📄 Giấy Phép & Tác Quyền

Phát triển bởi [hieu-gui-tools](https://github.com/hieu-gui-tools). Sử dụng hoàn toàn miễn phí cho mục đích cá nhân và tối ưu hóa hệ thống.
