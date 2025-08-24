import tkinter as tk

root = tk.Tk()
root.title("Normal Interface")
root.geometry("500x500")  # Set window size to 500x500 pixels

label = tk.Label(root, text="Hello, Tkinter!", font=("Arial", 20))
label.pack(pady=20)

root.mainloop()
