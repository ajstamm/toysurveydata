# AoS conference 2026

I was asked to co-present a workshop on how to clean and validate community health assessment (CHA) data. Since CHA data are considered protected data, I needed to build a fake dataset for the workshop. I chose some questions from actual CHAs in Minnesota, which were slightly modified by my colleague based on her CHA work in Kentucky. 

When I built the dataset below, I used US census populations to assign probabilities for Minnesota counties and Gallup poll estimates to assign probabilities for several of the demographic questions.


Files used in my presentation for the 2026 AoS conference:

* [mock_cha_data.csv](mock_cha_data.csv): the final toy dataset after: 
    * running the functions in the package (see [create_toy_cha_dataset.R])
	* post-processing to add respondent ages and counties of residence
	* introducing deliberate errors
	* adding text field responses
	* uploading to and redownloading from Alchemer
* [cha_codebook.xlsx](cha_codebook.xlsx): the codebook that describes the data.
* [Survey_Mind-the-Mess.pdf](Survey_Mind-the-Mess.pdf): the survey instrument in portable document format (PDF), downloaded from Alchemer.

Files used to build the dataset, in case you want to create your own:

* [cha_probabilities.csv](cha_probabilities.csv): the settings dataset on which I ran the package functions. 
* [health_priority_options.csv](health_priority_options.csv): the optional responses for the open text question about health priorities.
* [create_toy_cha_dataset.R](create_toy_cha_dataset.R): the script used to create the dataset.

