# LHD AoS conference 2026

I was asked to co-present a workshop at the Local Health Department Academy of Science 2026 Conference on how to clean and validate Community Health Assessment (CHA) data. Since CHA data are considered protected data, I needed to create a fake dataset for the workshop. I chose some questions from actual CHAs in Minnesota, which were slightly modified by my co-presenter based on her CHA work in Kentucky. 

When I built the dataset below, I used US census populations to assign probabilities for Minnesota counties and Gallup poll estimates to assign probabilities for several of the demographic questions.


Files used in my presentation for the 2026 AoS conference:

* [cha_codebook.xlsx](cha_codebook.xlsx): the codebook that describes the data.
* [Survey_Mind-the-Mess.pdf](Survey_Mind-the-Mess.pdf): the survey instrument in portable document format (PDF), downloaded from Alchemer.
* [mock_cha_final.csv](mock_cha_final.csv): the final toy dataset after:
	* running the code to create it
	* uploading to and redownloading from Alchemer

Files used to build the dataset, in case you want to create your own:

* [cha_probabilities.csv](cha_probabilities.csv): the settings dataset on which I ran the package functions. 
* [health_priority_options.csv](health_priority_options.csv): the optional responses for the open text question about health priorities.
* [create_toy_cha_dataset.R](create_toy_cha_dataset.R): the script used to create the dataset, including: 
    * running the functions in the package 
	* calculating respondent ages and regions of residence
	* introducing deliberate errors
	* adding text field responses


