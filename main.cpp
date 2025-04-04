#include <iostream>
#include <opencv2/opencv.hpp>

int main(int argc, const char** argv)
{
	int ret = EXIT_FAILURE;
	try{
		cv::Mat src = cv::imread("/Users/sclin/sclinWorkDirectory/projects/00.Test/TestOpenImageDebugger/TestingImages/lena.bmp", cv::IMREAD_COLOR);
		cv::Mat dst;
		cv::cvtColor(src, dst, cv::COLOR_RGB2GRAY);

		// cv::namedWindow("src", cv::WINDOW_NORMAL);
		// cv::imshow("src", src);

		// cv::namedWindow("dst", cv::WINDOW_NORMAL);
		// cv::imshow("dst", dst);
		// cv::waitKey(0);
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
	std::cout << "Finished testing. Press any key to exit." << std::endl;

	int key = getchar();
	return ret;
}