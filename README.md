# HerbSnap
iOS app for classifying garden herbs based on a camera image.
<br/>
<h2>Description</h2>
HerbSnap is an app for classifying herbs based on photos of the plant. As input data, a photo can either be taken directly via the app or an existing image from the gallery can be opened. The app processes the data on the device and uses artificial intelligence to determine the herb species. Two different prediction models are available, which can be switched between using the button in the upper right corner. One model was generated with CreateML from Apple and the other with TensorFlow from Google. As result, the detected herb species is output, with a direct link to the Wikipedia page for more information. If the prediction of the model is not completely clear, the two most probable prediction classes are output.
<br/>
This app was created as part of the student research thesis at DHBW Stuttgart.

<h2>Supported herb species</h2>

Currently, the two models support the following herbal classes:
* x
* y

<h2>Screenshots</h2>

![01_Overview of the app pages](https://user-images.githubusercontent.com/88625959/211192591-0ed18752-a646-4b38-b251-49ac3d2551bd.png)

<b>Figure 1:</b> <i>Overview of the capture screen, photo selection and about page</i>
<br/><br/>

![02_Result presentation](https://user-images.githubusercontent.com/88625959/211192618-55255335-b8f1-409d-beaf-8df818d112ed.png)

<b>Figure 2:</b> <i>Result presentation and link to Wikipedia page</i>
<br/><br/>
