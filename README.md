# calligraphy-background-fix
This is a matlab code to fix the bachground of Chinesecalligraphy.

1. 在计算机中使用软件读取待处理的书法作品的彩色图像；

2. 观察书法作品背景，选择包含较少噪声的高质量背景区域；

3. 利用单幅图像超分辨率算法，以步骤二中选出的背景区域作为输入样本图像，重建新的背景图像；

4. 利用K近邻抠图算法，分割书法作品的背景与文字、印章，得到文字和印章信息；

5. 对步骤三中新的背景图像和步骤四中文字、印章信息进行像素级的图像融合，完成。

# v0.2
1. 加入vlfeat-0.9.20工具箱
2. knnmatting加入主程序，不需要另外运行knn mating获取三个图层
