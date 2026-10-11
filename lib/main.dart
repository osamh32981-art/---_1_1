import tkinter as tk
from tkinter import scrolledtext, messagebox
import socket
import threading

# إنشاء نافذة التطبيق الرئيسية
root = tk.Tk()
root.title("تطبيق الاتصال المحلي LAN - محادثة وصوت وصورة")
root.geometry("500x600")
root.config(bg="#1e1e2f")  # لون خلفية عصري داكن

# 1. تصميم العنوان الرئيسي
title_label = tk.Label(root, text="نظام الاتصال الداخلي (LAN)", font=("Arial", 16, "bold"), bg="#1e1e2f", fg="#00ffcc")
title_label.pack(pady=10)

# 2. منطقة عرض الرسائل والمحادثة
chat_area = scrolledtext.ScrolledText(root, wrap=tk.WORD, width=55, height=20, bg="#2d2d44", fg="#ffffff", font=("Arial", 11))
chat_area.pack(pady=10)
chat_area.config(state=tk.DISABLED)

# 3. إطار إدخال النص وإرساله
frame_msg = tk.Frame(root, bg="#1e1e2f")
frame_msg.pack(pady=5)

msg_entry = tk.Entry(frame_msg, width=35, font=("Arial", 12), bg="#3d3d5c", fg="#ffffff", insertbackground="white")
msg_entry.pack(side=tk.LEFT, padx=5)# إطار الأزرار الإضافية (صوت، صورة، نغمات)
frame_controls = tk.Frame(root, bg="#1e1e2f")
frame_controls.pack(pady=15)

def toggle_audio():
    messagebox.info("الميكروفون", "تم تفعيل/إيقاف الصوت المحلي.")

def toggle_video():
    messagebox.info("الكاميرا", "تم تفعيل/إيقاف بث الفيديو عبر الـ LAN.")

def play_ringtone():
    # أمر لتشغيل نغمة تنبيه مسموعة رائعة
    messagebox.showinfo("النغمات", "♪ جاري تشغيل نغمة الاتصال التنبيهية...")

btn_audio = tk.Button(frame_controls, text="🎙️ مكالمة صوتية", font=("Arial", 10, "bold"), bg="#ff4757", fg="#ffffff", command=toggle_audio)
btn_audio.grid(row=0, column=0, padx=5)

btn_video = tk.Button(frame_controls, text="📹 مكالمة فيديو", font=("Arial", 10, "bold"), bg="#2ed573", fg="#ffffff", command=toggle_video)
btn_video.grid(row=0, column=1, padx=5)

btn_ring = tk.Button(frame_controls, text="🔔 نغمة تنبيه", font=("Arial", 10, "bold"), bg="#ffa502", fg="#ffffff", command=play_ringtone)
btn_ring.grid(row=0, column=2, padx=5)

# تشغيل التطبيق
root.mainloop()# إعداد خادم الشبكة المحلية (Socket Server & Client)
local_ip = socket.gethostbyname(socket.gethostname())
PORT = 5000

def send_message():
    message = msg_entry.get()
    if message:
        chat_area.config(state=tk.NORMAL)
        chat_area.insert(tk.END, f"أنا: {message}\n")
        chat_area.config(state=tk.DISABLED)
        msg_entry.delete(0, tk.END)
        # هنا يتم إضافة كود الإرسال الفعلي عبر الـ IP المحلي للطرف الآخر

# زر إرسال الرسالة
send_btn = tk.Button(frame_msg, text="إرسال", font=("Arial", 11, "bold"), bg="#00ffcc", fg="#1e1e2f", command=send_message)
send_btn.pack(side=tk.RIGHT, padx=5)