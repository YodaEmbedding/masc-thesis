---
# mainfont: Times.ttf
# mainfont: OpenSans-Regular.ttf
mainfont: DejaVuSans.ttf
linestretch: 1.25
---

## Introduction (1:30)

**1 ---** (0:10) (0:00 elapsed)
Welcome.
My name is Mateen Ulhaq, and today I will be presenting my Master's thesis on "Learned compression of images and point clouds".

**2 ---** (0:20) (0:10 elapsed)
Today, we will be looking at three main topics.
First is the learned compression of "encoding distributions" that are used in compression.
Second is the learned compression of point clouds for classification.
Third is an analysis of the motion within the latent space of a deep learning model.

**3 ---** (1:00) (0:30 elapsed)
This diagram shows a comparison between various lossy image compression codecs.
In compression, the two main goals are to maximize the quality of the reconstructed image, and to minimize the bitrate.
Over the years, codecs have gotten better at compressing images without sacrificing quality.
The bottommost curve is the JPEG codec, which was developed in 1992.
The topmost curve is a recent deep learning based codec from 2022.
It achieves a much lower bitrate for any given quality.
However, it is also much more computationally expensive.
This is one big reason why deep learning based codecs have not yet gained popularity.
There are efforts being taken to reduce the computational requirements of learned codecs.
One of these efforts includes the work that will be presented the first section.

**4 ---** (0:00) (1:30 elapsed)
Empty.



## Learned compression of encoding distributions (8:40)

**5 ---** (0:06) (1:30 elapsed)
The first work we look at is the learned compression of encoding distributions that are used in compression.

**6 ---** (1:24) (1:36 elapsed)
This figure shows a standard compression architecture.
In this architecture, the input is first transformed into an intermediate latent representation `y`.
The purpose of this first transform is to eliminate most of the spatial redundancy within the input.
Then, `y` is quantized into a tensor of integers, which we denote by `y_hat`.
Next, we losslessly compress and transmit the bitstream to the receiver.
The length of the compressed bitstream is the bitrate, denoted as `R`.
The receiver decompresses the bitstream to obtain `y_hat`.
Finally, we apply an inverse transform to get a reconstruction of the desired input image called `x_hat`.
The distortion between the input `x` and output `x_hat` measures the drop in image quality by our compression method.
As visualized in the earlier slides, the goal of compression is to minimize the rate as well as the distortion.
Thus, the loss function that we minimize is the sum of rate and distortion, with some tradeoff factor between them labeled λ.
The larger the λ, the more emphasis is put on improving quality, rather than minimizing rate.

**7 ---** (0:32) (3:00 elapsed)
A given element `y_hat_i` is encoded using an encoding distribution `p(y_hat_i)`.
The encoding distribution describes the likelihood of various values that the element can take.
The bit cost of encoding that element is equal to the negative log of that likelihood.
As shown here, the better the encoding distribution predicts the given value, the fewer bits are required to encode that element.

**8 ---** (0:45) (3:32 elapsed)
Next, we look at how a learned compression model performs lossless compression of the latent tensor `y`.
This tensor is visualized as a 3D cube, with the height and width dimensions facing us, and the channels going depthwise.
Each element of this tensor is encoded using an encoding distribution.
In the visualization, each color represents the use of a different encoding distribution.
In this case, the same encoding distribution is used for all elements within a given channel.
This is known as the fully factorized entropy model.
It is used in many state-of-the-art learned compression models as a building block for more advanced entropy models.

**9 ---** (0:40) (4:17 elapsed)
In Ballé et al.'s, the fully factorized entropy model's encoding distributions are static.
That is, they do not change and adapt to the input data.
Thus, during training of the learned compression model, the distributions that are learned are conservative, and try to account for all possible inputs.
Unfortunately, in trying to be a master of all, they end up being a master of none.
This phenomenon is known as the amortization gap.
To address this issue, we propose a method that dynamically encodes and transmits a better-adapted encoding distribution.

**10 ---** (0:27) (4:57 elapsed)
We represent all encoding distributions as a 2D heatmap.
Each vertical slice represents a single encoding distribution.
The color intensity is its negative log likelihood, which can be thought of as the bit cost of encoding a value that falls within that bin.
Across the horizontal axis are different channels.

**11 ---** (0:35) (5:24 elapsed)
This figure shows an input image on the left.
Its best possible encoding distributions are shown in the middle.
The actual encoding distributions used are shown on the right.
In this case, the actual encoding distributions used are static.
Notice the mismatch between the corresponding ideal and actual encoding distributions.
This happens because the static distributions try to account for different images.

**12 ---** (0:23) (5:59 elapsed)
For example, here is another image.
The ideal encoding distributions are now different.
Yet the ones we encode using are still the same as for the previous image.
Once again, there is a mismatch between the ideal and actual distributions.

**13 ---** (0:06) (6:22 elapsed)
One solution is to transmit per-image adapted encoding distributions.

**14 ---** (0:39) (6:28 elapsed)
Our proposed architecture is shown here.
The histogram module measures the ideal encoding distribution, labeled as `p`, using a differentiable kernel density estimator.
We then compress `p` in the typical way by transforming it into `q`.
This is quantized and encoded to generate a bitstream with rate `R_q`.
We then decompress and reconstruct the encoding distributions `p_hat`.
This is used to encode `y`, generating another bitstream with rate `R_y`.

**15 ---** (0:10) (7:07 elapsed)
Another equivalent way to measure the rate `R_y` is to compute the cross entropy between `p` and `p_hat`.

**16 ---** (0:18) (7:17 elapsed)
The transform blocks we used in our architecture are shown here.
It consists of 1D grouped convolutions interleaved with channel shuffles.
These blocks are quite light, so the total number of parameters in the entire architecture do not increase by much.

**17 ---** (0:13) (7:35 elapsed)
Here, we have applied our proposed method.
This time, the distributions used for encoding much more closely match the ideal encoding distributions.

**18 ---** (0:07) (7:48 elapsed)
This image also shows much better adaptation.

**19 ---** (0:30) (7:55 elapsed)
We minimize the loss function shown here while training our model.
The loss is just the sum of rates and distortion.
However, we also introduce a λ`_q` factor for the rate of `q`.
This factor is the ratio between the number of times we use a given encoding distribution in the small image patch we trained on and the desired image we are compressing.

**20 ---** (0:27) (8:25 elapsed)
We tested our proposed method on top of Ballé et al.'s factorized architecture.
We froze the weights of the pretrained model's transforms and only trained our encoding distribution compression model.
We were able to achieve a rate savings of 7%, in comparison with the theoretical bound of 8.3% for this entropy model with the given pretrained weights.

**21 ---** (0:16) (8:52 elapsed)
This table compares our learned compression model for encoding distributions with a prior non-learned method.
Our method attains a larger reduction in rate that is much closer to the theoretical gap.

**22 ---** (0:22) (9:08 elapsed)
This table compares our side information architecture with the scale hyperprior.
Ours is much lighter and lower in complexity, though the scale hyperprior offers better compression.
However, these methods can likely be combined in some way to give improvements to both.

**23 ---** (0:40) (9:30 elapsed)
In summary, we proposed a new method for the compression of encoding distributions.
Our method achieves 7% rate improvement versus 8.3% ideal for the factorized entropy model.
Future work involves devising a working fully end-to-end adaptive entropy bottleneck, an adaptive distribution correction model for the Gaussian conditional, and non-parametric modeling of the encoding distributions.

**24 ---** (0:00) (10:10 elapsed)
Empty.




## Learned point cloud compression for classification (6:33)

**25 ---** (0:09) (10:10 elapsed)
The next work we look at is learned point cloud compression for classification, which was presented at MMSP 2023.

**26 ---** (0:36) (10:19 elapsed)
This diagram compares the inference latency for various inference strategies.
Inference on only the edge device does not require transmitting any data, so it is constant with respect to available bitrate.
Cloud-only inference, on the other hand, depends highly on the available bitrate.
Shared edge-cloud inference is a blend of both, and is optimal over some interval of available bitrate.
Our method is based on this last technique.

**27 ---** (0:53) (10:55 elapsed)
This slide shows the PointNet architecture, which accepts a list of 3D points and outputs classification labels.
PointNet can be thought of as an input permutation invariant function that is composed of three smaller functions: h, pi, and gamma.
A shared MLP is applied to each input point individually and identically.
That is, there is no interaction between the points.
The resulting features are all then mixed together using an input permutation invariant operation such as max pooling.
This makes the network input permutation invariant.
This is important because there is no inherent ordering to the points in a point cloud, so we should avoid learning dependencies between them that depend upon the order.

**28 ---** (0:10) (11:48 elapsed)
This shows a high-level view of our proposed architecture.
It is a typical compression architecture, except that it outputs class labels labeled `t_hat`.

**29 ---** (0:41) (11:58 elapsed)
Here is a more detailed view of our architecture.
The encoder-side transform consists of five encoder blocks, which are made of 1D convolutions with a kernel size of 1.
Then, a pooling operation reduces the features along the pointwise axis.
The resulting vector is multiplied by a gain vector for faster convergence to generate `y`.
Then, `y` is quantized, encoded, and transmitted to the server.
The server decodes `y_hat` and then runs the classifier MLP.
We tested three model sizes: full, lite, and micro.

**30 ---** (0:19) (12:39 elapsed)
We trained our models on point clouds sampled from the ModelNet40 dataset.
The minimized loss function is the sum of rate and distortion, where the distortion is the cross-entropy loss.
We trained models for different lambdas, numbers of points, and architecture sizes.

**31 ---** (0:28) (12:58 elapsed)
This plot compares the classification accuracy against the rate.
We tested our full codec for various numbers of input points.
For comparison, we also tested an input compression codec for server-only classification using the tmc13 standard codec.
Our classification-specialized codec architecture shows better results than the non-specialized input compression codec.

**32 ---** (0:33) (13:26 elapsed)
These plots show the rate-accuracy curves for our proposed lite and micro-sized codecs.
These smaller codecs achieve results similar to our full-sized codec.
However, due to their limited capacity, they saturate at a rate of approximately 100 bits.
Interestingly, the micro codec shows surprisingly good results on this dataset even though it is only just a single pointwise convolutional layer.

**33 ---** (0:15) (13:59 elapsed)
This table summarizes our results in terms of the maximum attainable accuracy and the BD-rate improvement over the baseline tmc13 input compression codec.

**34 ---** (0:25) (14:14 elapsed)
For visualization purposes, we trained an auxiliary reconstruction network that minimizes the distortion between `x` and `x_hat` in terms of the Chamfer distance.
This reconstruction is performed on a detached `y_hat` to prevent reconstruction distortion from affecting the main network.

**35 ---** (0:29) (14:39 elapsed)
We also define the critical point set.
For a specific codec, the critical point set is a minimal subset of the input point cloud that generates the exact same compressed bitstream as the input point cloud.
For example, here we encode the entire point cloud on top and its critical point set on the bottom.
These both generate the same bitstream, and thus, they generate the exact same outputs, too.

**36 ---** (1:00) (15:08 elapsed)
Here are various reconstructions of a class-representative sample point cloud of an airplane at various bitrates.
The critical points are marked in red.
Due to the architecture-enforced constraints, there are only at most 16 critical points in the lite codec.
This means that only a few points are encoded for transmission for the smaller codecs.
These few points require a relatively minimal rate of 50 bits to achieve 80% classification accuracy.
The full-sized codec achieves lower rate still, though it blends information from a larger number of critical points.
Interestingly, our codec comes quite close to an ideal codec, which would achieve 80% accuracy at 3.2 bits.
This is despite the fact that no information mixing between points occurs, except for a single max pool.
Although the reconstructed point clouds look quite good for the low rate, it should be noted that the ModelNet40 dataset is relatively simple, so these results do not necessarily extend to the compression of general point clouds just yet.

**37 ---** (0:35) (16:08 elapsed)
In summary, we proposed a new codec for point cloud classification, facilitating progress towards achieving more capable end devices.
Our "full" codec improves in rate-accuracy versus traditional methods.
Our "lite" and "micro" codecs achieve similar improvements in rate-accuracy, while consuming minimal edge-side computational resources.
For future work, we may explore other point cloud tasks such as segmentation and object detection, more powerful models for real-world datasets, and scalable multi-task codecs.

**38 ---** (0:00) (16:43 elapsed)
Empty.




## Latent space motion analysis (4:51)

**39 ---** (0:06) (16:43 elapsed)
Next, we look our work on latent space motion analysis, which was presented at ICASSP 2021.

**40 ---** (0:24) (16:49 elapsed)
Processing an input frame through part of a deep learning model yields a feature tensor that inhabits the latent space.
When designing video compression methods that work within the latent domain, one might wonder:
How does motion between input frames correspond to the motion between the feature tensors?
Given a reference tensor and the motion between consecutive input frames, how well can we predict the next tensor?

**41 ---** (0:45) (17:13 elapsed)
This video shows a comparison between the input on the left and a feature tensor channel taken from a couple of layers deep within a convolution neural network.
One can see that motion within the tensor channel roughly corresponds to the motion within the input video.
This particular tensor channel seems to act as a vertical edge detector.
If we look closely, we will see that the motion does not exactly match.
Notice that the dark blue edge disappears as the wind turbine rotates to a certain angle, and then reappears after a certain angle.
Thus, there isn't a perfect correspondence of the motion across domains.
How much error is there if we try to predict the tensor using the input motion?
In the following slides, we will show some quantitative results that express how much error there is.

**42 ---** (0:30) (17:58 elapsed)
We conducted some experiments to determine how well we can predict the next tensor.
We assumed that the latent motion is equal to a rescaled version of the motion between input frames.
Using the latent motion, we warped the reference tensor to predict the next tensor.
Then, we calculated the normalized root-mean-square error (NRMSE) between the predicted tensor and the actual tensor.

**43 ---** (1:03) (18:28 elapsed)
On the top row, we have a reference image that we started with, and its corresponding ground truth reference tensor on the right.
In each row, we see a different transformation being applied to the image, namely, translation, rotation, scaling, and shearing.
Using the idea of "rescaled motion", we take the reference tensor, and the known motion between the input frames in order to predict what the tensor looks like in the transformed image.
For instance, here we have applied a horizontal translation to the reference image, and so we apply the same horizontal translation motion to the reference tensor in an attempt to predict the tensor without actually performing any deep model inference.
We see that the error difference between the actual tensor from the deep model and the estimated tensor is fairly minimal.
We then use this difference to compute the NRMSE, which we show on the next slide.

**44 ---** (0:45) (19:31 elapsed)
Here, we have quantified the errors for each of the basic transformations, namely translation, rotation, scaling, and shearing.
For instance, in the top-left plot, we show how much reconstruction error there is in translations.
The various curves represent various deep layers within ResNet-34 and DenseNet-121.
On the top-right, we see how the error changes with respect to rotation.
The more rotation is applied, the larger the error becomes.
However, as long as there isn't too much rotation between successive frames, the error stays below 4% NRMSE.

**45 ---** (0:40) (20:16 elapsed)
Here, we performed general 6-parameter affine transformations that were randomly generated within the parameter ranges specified, and then attempted to reconstruct the feature maps at various deep layers.
This results in the following distributions of normalized root-mean-square errors.
The means of the distributions are all below a NRMSE of 0.04.
For comparison, this corresponds to a PSNR of 28 dB for regular images.
For additional perspective, the distributions of these deeper layers within these convolutional models are only at most 4 times worse than at the conv0 layer, which is visualized by the blue curve.

**46 ---** (0:38) (20:56 elapsed)
In conclusion, we validated a simple approximate relationship of motion between consecutive feature tensors.
We also found that the prediction error for small affine transformations within the input is 4% NRMSE.
Potential applications of this work include learned video codecs that do motion warping directly within the latent domain, rather than in the input domain as the Scale-space flow model does.

**47 ---** (0:00) (21:34 elapsed)
Empty.




## Conclusion (0:55)

**48 ---** (0:45) (21:34 elapsed)
In conclusion, we looked at three main topics.
First, we proposed a new method for the compression of encoding distributions.
Then, we introduced a shared client-server inference codec for point clouds that is specialized for classification.
Finally, we investigated the prediction error of a simple motion model within the latent space, which may be useful for designing learned video compression codecs.
Learned compression shows promise, though we must reduce its complexity for it to become practical.
Hopefully, some of the work that was presented today takes steps in this direction.

**49 ---** (0:06) (22:19 elapsed)
These are the publications and other work done during my Master's degree.

**50 ---** (0:04) (22:25 elapsed)
Thank you for attending this presentation.

**51 ---** (0:00) (22:29 elapsed)
Empty.



<!--
0:10 0:30 1:30 1:30 1:36 3:00 3:32 4:17 4:57 5:24 5:59 6:22 6:28 7:07 7:17 7:35 7:48 7:55 8:25 8:52 9:08 9:30 10:10 10:10 10:19 10:55 11:48 11:58 12:39 12:58 13:26 13:59 14:14 14:39 15:08 16:08 16:43 16:43 16:49 17:13 17:58 18:28 19:31 20:16 20:56 21:34 21:34 22:19 22:25 22:29
-->

































<!--
In figure (a) is the standard input compression pipeline.
The input point cloud is first encoded as a bitstream.
This is then transmitted over the network to the server, which decompresses the point cloud and then performs the classification task on it.
One disadvantage of this approach is that the bitstream contains redundant information that is not needed for accurate classification.
This is because most point cloud codecs are optimized for human viewing, and not for classification.
Since most point cloud codecs are optimized for human viewing, they contain a lot of redundant information that is not needed for accurate classification.
One disadvantage of this approach is that the bitstream contains redundant information
In figure (b) is the pipeline our work uses.
This is optimized for classification.
The edge device performs part of the classification task on the device itself, while performing compression simultaneously.
The latent representation `y` is then encoded as a bitstream and transmitted over the network to the server.
The server decodes the latent representation and performs the rest of the classification task.
-->

<!--
This slide shows the PointNet architecture.
The input point cloud goes through an MLP that is applied to each point individually.
That is, there is no interaction between the points.
Thus, this part of the network is input permutation invariant.
This is important because there's no inherent ordering to the points in a point cloud, so we should avoid learning dependencies between them, without further guidance.
The resulting features are all then mixed together using another input permutation invariant operation, max pooling.
-->

<!--
In collaborative intelligence, deep learning models can be split into two parts.
The first half of the model runs on the edge device, and the second half runs somewhere in the cloud.
The intermediate feature tensors are transmitted over the network.
-->

<!--
Depending on the filter, the motion itself need not be exactly determined by the preceding layer's motion.
However, any inaccuracies this causes are limited to the filter window size.
-->

<!--
Sounds obvious, but let’s look closely.
Notice that dark blue edge disappears as the blade rotates to a certain angle, and then reappears after a certain angle.
But how much error is there in a simple motion model?
Can we quantify it?
In the following slides, we will show why this is to be expected and establish a relationship between them.
We will also show some quantitative results that express how accurately this relationship models the motion.
-->


