/*
 * @Author: Your Name your.email@example.com
 * @Date: 2023-12-19 01:23:33
 * @LastEditors: Your Name your.email@example.com
 * @LastEditTime: 2024-01-23 21:40:53
 * @FilePath: /TUP-InfantryVision-2022-main/autoaim/detector/inference.h
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
#include <iterator>
#include <memory>
#include <string>
#include <vector>
#include <iostream>
#include <inference_engine.hpp>
#include <Eigen/Core>
#include <opencv2/opencv.hpp>

#include "../../general/general.h"

using namespace std;
using namespace cv;
using namespace InferenceEngine;

struct ArmorObject
{
    Point2f apex[4];
    cv::Rect_<float> rect;
    int cls;
    int color;
    int area;
    float prob;
    std::vector<cv::Point2f> pts;
};


class ArmorDetector
{
public:
    ArmorDetector();
    ~ArmorDetector();
    bool detect(Mat &src,vector<ArmorObject>& objects);
    bool initModel(string path);
private:

    Core ie;
    CNNNetwork network;                // 网络
    ExecutableNetwork executable_network;       // 可执行网络
    InferRequest infer_request;      // 推理请求
    MemoryBlob::CPtr moutput;
    string input_name;
    string output_name;
    
    Eigen::Matrix<float,3,3> transfrom_matrix;
};
