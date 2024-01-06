#include <iostream>
#include <opencv2/opencv.hpp>

int main(int argc, const char** argv)
{
	int ret = EXIT_FAILURE;
	try{
		cv::Mat src = cv::imread("lena.jpg", cv::IMREAD_COLOR);
		cv::Mat dst;
		cv::cvtColor(src, dst, cv::COLOR_RGB2GRAY);
		ret = EXIT_SUCCESS;
	}
	catch(cv::Exception& e){
		std::cout << e.what() << std::endl;
	}
	catch(std::exception& e){
		std::cout << e.what() << std::endl;
	}
	catch(...){
		std::cout << "Unknown exception" << std::endl;
	}

	int key = getchar();
	return ret;
}