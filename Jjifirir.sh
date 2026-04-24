<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>AI QR Code Generator</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #0f172a;
      color: white;
      text-align: center;
      padding: 50px;
    }
    .container {
      background: #1e293b;
      padding: 30px;
      border-radius: 12px;
      max-width: 400px;
      margin: auto;
      box-shadow: 0 0 20px rgba(0,0,0,0.5);
    }
    input {
      width: 100%;
      padding: 10px;
      border-radius: 8px;
      border: none;
      margin-bottom: 15px;
    }
    button {
      padding: 10px 20px;
      border: none;
      border-radius: 8px;
      background: #22c55e;
      color: white;
      cursor: pointer;
      margin: 5px;
    }
    #qrcode {
      margin-top: 20px;
    }
    a {
      display: block;
      margin-top: 15px;
      color: #38bdf8;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>AI QR Code Generator</h2>
  <input type="text" id="urlInput" placeholder="Enter destination URL">
  <button onclick="generateQR()">Generate QR Code</button>
  <button onclick="downloadQR()">Download PNG</button>

  <div id="qrcode"></div>
  <a id="downloadLink" style="display:none;">Download QR Code</a>
</div>

<script>
let qr;

function generateQR() {
  const url = document.getElementById("urlInput").value.trim();
  const qrContainer = document.getElementById("qrcode");
  qrContainer.innerHTML = "";

  if (!url) {
    alert("Please enter a URL");
    return;
  }

  qr = new QRCode(qrContainer, {
    text: url,
    width: 200,
    height: 200,
  });
}

function downloadQR() {
  const img = document.querySelector("#qrcode img");
  const canvas = document.querySelector("#qrcode canvas");

  let dataURL;

  if (img) {
    dataURL = img.src;
  } else if (canvas) {
    dataURL = canvas.toDataURL("image/png");
  } else {
    alert("Generate QR code first!");
    return;
  }

  const link = document.createElement("a");
  link.href = dataURL;
  link.download = "qrcode.png";
  link.click();
}
</script>

</body>
</html>
