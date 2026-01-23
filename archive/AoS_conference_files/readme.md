# LHD AoS conference 2026

I was asked to co-present a workshop at the [Local Health Department Academy of Science (LHD AoS) Conference](https://lhdacademyofscience.org/aos-national-conference/) for 2026 on how to clean and validate Community Health Assessment (CHA) data. Since CHA data are considered protected data in Minnesota, I needed to create a fake dataset for the workshop. I chose some questions from actual Minnesota CHAs, which were then modified by my co-presenter, Lyndsey Blair, based on her CHA work in Kentucky. 

## Files used in our workshop

If you are attending the workshop, please download these.

* [cha_codebook.xlsx](cha_codebook.xlsx): the codebook that describes the data.
* [Survey_Mind-the-Mess.pdf](Survey_Mind-the-Mess.pdf): the survey instrument in portable document format (PDF), downloaded from Alchemer.
* [mock_cha_final.csv](mock_cha_final.csv): the final toy dataset after:
	* running the code to create it
	* making a few manual adjustments to ensure examples for some validation checks
	* uploading to and redownloading from Alchemer

## Files used to build the dataset

Feel free to try them to create your own dataset.

* [cha_probabilities.csv](cha_probabilities.csv): the settings dataset on which I ran the package functions. I used US census populations to assign probabilities for Minnesota counties and Gallup poll estimates to assign probabilities for several of the demographic questions.
* [health_priority_options.csv](health_priority_options.csv): the optional responses for the open text question about health priorities.
* [create_toy_cha_dataset.R](create_toy_cha_dataset.R): the script used to create the dataset, including: 
    * running the functions in the package 
  	* calculating respondent ages and regions of residence
  	* introducing deliberate errors
  	* adding text field responses

## Workshop citation

Blair, Lyndsey, and Stamm, Abigail. *Mind the Mess: Preparing Survey Data for Public Health
Analysis*. Local Health Department Academy of Science National Conference. Virtual, January 28, 2026.

I will include a link to the workshop recording when it is available.


