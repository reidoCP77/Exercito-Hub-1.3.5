import tkinter as tk
patentes = ["rec", "sld", "cb", "tsgt"]
player1 = patentes[2]
player2 = patentes[3]
# fnc1's
def verifyp():
  if player1 == patentes[3]:
    mov_port = True;
  else:
    mov_port(0)
  if player2 == patentes[3]:
    mov_port(1)
  else:
    mov_port = False;
def mov_port(n):
  if n == 0:
    
# -------------
x1 = 50
y1 = 50
x2 = 250
y2 = 250-100
# -----------
root = tk.Tk()
root.title("Portão mov, anim")
root.geometry("500x500")  # Set window size to 500x500 pixels

canvas = tk.Canvas(root, width=300, height=200)
canvas.pack()

# (x1, y1, x2, y2)
canvas.create_rectangle(x1, y1, x2, y2, fill="gray")
label = tk.Label(root, text="Hello, Tkinter!", font=("Arial", 20))
label.pack(pady=20)

# buttons
btn1 = tk.Button(root, text="abrir", command=verifyp)
btn1.pack(pady=10)
btn2 = tk.Button(root, text="fechar", command=verifyp2)
btn2.pack(pady=10)

root.mainloop()
