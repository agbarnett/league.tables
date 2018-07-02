# data.management.R
# manage the data to create consistent naming
# June 2018
library(readxl)
library(stringr)

## manage papers data
load('Papers.RData') # from equator.data.R
papers.temp = papers
load('Papers2.RData') # from equator.data.R
papers = rbind(papers, papers.temp); rm(papers.temp) # combine two data sets
# make year
papers$year = as.numeric(substr(as.character(papers$date),1,4))
# one edit
papers$country[papers$country=='Geneve'] = 'Switzerland'
# add region (had to edit some countries by hand)
region = read_excel('country.data.xls', skip=2)
# merge region with papers (include missing)
papers = merge(papers, region, by.x='country', by.y='Country', all.x=T)
papers$affiliation = as.character(papers$affiliation)
# fix some special characters
papers$affiliation = gsub('ï¿½', 'é', papers$affiliation)
papers$affiliation = gsub('&amp;', '&', papers$affiliation)
papers$affiliation = gsub('Hopital ', 'Hôpital ', papers$affiliation) # to be consistent and give better merge with Leiden
# fixes for merge with Leiden
papers$affiliation = gsub("St Mary's Hospital London", "St. Mary's Hospital, London", papers$affiliation) # 
papers$affiliation = gsub("All India Institute of Medical Sciences, New Delhi", "All India Institute of Medical Science, New Delhi", papers$affiliation) # 
papers$affiliation = gsub("Ataturk University, Faculty of Medicine","Atatürk University", papers$affiliation)
papers$affiliation = gsub("Universitatea Babes-Bolyai din Cluj-Napoca", "Babeș-Bolyai University", papers$affiliation)
papers$affiliation = gsub('Universita degli Studi di Brescia|Universita degli Studi di Brescia, Facolta di Medicina e Chirurgia',"Brescia University" , papers$affiliation)
papers$affiliation = gsub("Beijing An Ding Hospital, Capital Medical University|Capital Medical University China", "Capital Medical University", papers$affiliation)
papers$affiliation = gsub('Universitat Oldenburg','Carl von Ossietzky University of Oldenburg', papers$affiliation)
papers$affiliation = gsub('Charles University','Charles University, Prague', papers$affiliation)
papers$affiliation = gsub('Universite Claude Bernard, Faculte de Medecine RTH Laennec|Universite Claude Bernard Lyon 1', 'Claude Bernard Lyon 1 University', papers$affiliation)
papers$affiliation = gsub('Comenius University','Comenius University, Bratislava', papers$affiliation)
papers$affiliation = gsub('Universite Concordia','Concordia University', papers$affiliation)
papers$affiliation = gsub("Dokuz Eylul Universitesi|Dokuz Eylul Universitesi Tip Fakultesi", 'Dokuz Eylül University', papers$affiliation)
papers$affiliation = gsub("Technische Universiteit Eindhoven","Eindhoven University of Technology" , papers$affiliation)
papers$affiliation = gsub("Erciyes Universitesi",'Erciyes University', papers$affiliation)
papers$affiliation = gsub("Ernst-Moritz-Arndt-Universitat Greifswald|Universitatsklinikum Greifswald der Ernst-Moritz-Arndt-Universitat Greifswald|University Medicine Greifswald" , "Ernst-Moritz-Arndt University of Greifswald", papers$affiliation)
papers$affiliation = gsub('Universidade Federal de Pernambuco','Federal University of Pernambuco - UFPE', papers$affiliation)
papers$affiliation = gsub('Universidade Federal do Rio Grande do Norte','Federal University of Rio Grande do Norte - UFRN', papers$affiliation) # are some without north/south information
papers$affiliation = gsub('Universidade Federal do Rio Grande do Sul','Federal University of Rio Grande do Sul - UFRGS', papers$affiliation)
papers$affiliation = gsub('Universidade Federal de Santa Catarina|Federal University of de Santa Catarina/UFSC','Federal University of Santa Catarina - UFSC', papers$affiliation)
papers$affiliation = gsub('Universidade Federal de Sao Carlos','Federal University of São Carlos - UFSCar', papers$affiliation)
papers$affiliation = gsub('Freie Universitat Berlin','Freie Universität Berlin', papers$affiliation)
papers$affiliation = gsub("Friedrich Schiller Universitat Jena|Friedrich Schiller University Jena", 'Friedrich Schiller University in Jena', papers$affiliation)
papers$affiliation = gsub("Universiteit Gent",'Ghent University', papers$affiliation)
papers$affiliation = gsub("Goethe-Universitat Frankfurt am Main|Klinikum und Fachbereich Medizin Johann Wolfgang Goethe-Universitat Frankfurt am Main", 'Goethe University Frankfurt', papers$affiliation)
papers$affiliation = gsub("Gottfried Wilhelm Leibniz Universitat","Gottfried Wilhelm Leibniz Universität Hannover", papers$affiliation)
papers$affiliation = gsub("Medizinische Hochschule Hannover (MHH)","Hannover Medical School", papers$affiliation)
papers$affiliation = gsub('Universitat Heidelberg|Universitatsklinikum Heidelberg',"Heidelberg University", papers$affiliation)
papers$affiliation = gsub("Heinrich Heine Universitat", "Heinrich Heine University Düsseldorf", papers$affiliation)
papers$affiliation = gsub("Heriot-Watt University, Edinburgh", "Heriot-Watt University", papers$affiliation)
papers$affiliation = gsub("Humboldt-Universitat zu Berlin", "Humboldt-Universität zu Berlin", papers$affiliation)
papers$affiliation = gsub("Indiana University-Purdue University Indianapolis", "Indiana University - Purdue University Indianapolis", papers$affiliation)
papers$affiliation = gsub("Islamic Azad University", "Islamic Azad University Science & Research Tehran", papers$affiliation)
papers$affiliation = gsub("Uniwersytet Jagiellonski w Krakowie", "Jagiellonian University, Krakow", papers$affiliation)
papers$affiliation = gsub("Universidad Jaume I", "Jaume I University", papers$affiliation)
papers$affiliation = gsub("Johannes Gutenberg Universitat Mainz", "Johannes Gutenberg University Mainz" , papers$affiliation)
papers$affiliation = gsub("Julius-Maximilians-Universitat Wurzburg", "Julius Maximilian University of Würzburg", papers$affiliation)
papers$affiliation = gsub("Karolinska Institutet", "Karolinska Institute", papers$affiliation)
papers$affiliation = gsub("KU Leuven|KU Leuven– University Hospital Leuven|KU Leuven - University of Leuven Department of Rehabilitation Sciences", "Katholieke Universiteit Leuven", papers$affiliation)
papers$affiliation = gsub("Christian-Albrechts-Universitat zu Kiel", "Kiel University", papers$affiliation)
papers$affiliation = gsub("Kunming University of Science and Technology", "Kunming University of Science & Technology", papers$affiliation)
papers$affiliation = gsub("Universite Laval|Universite Laval, Faculte de medecine", "Laval University", papers$affiliation)
papers$affiliation = gsub("Universitat Leipzig|Universitatsklinikum Leipzig und Medizinische Fakultat", "Leipzig University" ,papers$affiliation) 
papers$affiliation = gsub("London School of Hygiene and Tropical Medicine", "London School of Hygiene & Tropical Medicine" ,papers$affiliation) 
papers$affiliation = gsub("Loyola University of Chicago", "Loyola University Chicago",papers$affiliation) 
papers$affiliation = gsub("Ludwig-Maximilians-Universitat Munchen|University of Ludwig-Maximillians", "Ludwig-Maximilians-Universität München",papers$affiliation)
papers$affiliation = gsub("Marmara Universitesi|Marmara Universitesi Tip Fakultesi", "Marmara University", papers$affiliation)
papers$affiliation = gsub("Martin-Universitat Halle-Wittenberg", "Martin Luther University of Halle-Wittenberg", papers$affiliation)
papers$affiliation = gsub("Metropolitan University (UAM)", "Metropolitan Autonomous University" , papers$affiliation)
papers$affiliation = gsub("National Central University" , "National Central University", papers$affiliation) 
papers$affiliation = gsub("National Chiao Tung University Taiwan", "National Chiao Tung University", papers$affiliation) 
papers$affiliation = gsub("Universidad Nacional de Cordoba" , "National University of Cordoba", papers$affiliation)
papers$affiliation = gsub("National University of Ireland Galway", "National University of Ireland, Galway", papers$affiliation)
papers$affiliation = gsub("Newcastle University, United Kingdom|University of Newcastle upon Tyne, Faculty of Medicine","Newcastle University", papers$affiliation)
papers$affiliation = gsub("Uniwersytet Mikołaja Kopernika w Toruniu","Nicholas Copernicus University of Torun", papers$affiliation)
papers$affiliation = gsub("North Carolina State University", "North Carolina State University Raleigh", papers$affiliation )
papers$affiliation = gsub("North-West University", "North West University", papers$affiliation )
papers$affiliation = gsub("Northeastern University China", "Northeastern University, China", papers$affiliation )                          
papers$affiliation = gsub("Northeastern University", "Northeastern University, USA", papers$affiliation )
papers$affiliation = gsub("Oregon Health and Science University", "Oregon Health & Science University", papers$affiliation )                      
papers$affiliation = gsub("Otto von Guericke University of Magdeburg", "Otto von Guericke University Magdeburg", papers$affiliation)
papers$affiliation = gsub("University of Plymouth", "Plymouth University", papers$affiliation)
papers$affiliation = gsub("Ecole Polytechnique de Montreal", "Polytechnique de Montréal", papers$affiliation)
papers$affiliation = gsub("Universitat Pompeu Fabra|Universitat Popmpeu Fabra (UPF)", "Pompeu Fabra University", papers$affiliation)
papers$affiliation = gsub("Pontificia Universidad Catolica de Chile", "Pontificia Universidad Católica de Chile",papers$affiliation)
papers$affiliation = gsub("Postgraduate Institute of Medical Education and Research", "Postgraduate Institute of Medical Education & Research",papers$affiliation)
papers$affiliation = gsub("Prince of Songkla University", "Prince Songkla University", papers$affiliation)
papers$affiliation = gsub("Purdue University", "Purdue University, Lafayette", papers$affiliation)
papers$affiliation = gsub("Queensland University of Technology QUT","Queensland University of Technology", papers$affiliation)
papers$affiliation = gsub("Universitat Rovira i Virgili", "Rovira i Virgili University", papers$affiliation)
papers$affiliation = gsub('University of Bochum', "Ruhr-Universität Bochum", papers$affiliation)
papers$affiliation = gsub("Universitatsklinikum des Saarlandes Medizinische Fakultat der Universitat des Saarlandes|Universitat des Saarlandes", "Saarland University", papers$affiliation)
papers$affiliation = gsub("Università degli Studi della Campania Luigi Vanvitelli", "Second University of Naples", papers$affiliation)
papers$affiliation = gsub("Selcuk Universitesi|Seléuk éniversitesi", "Selçuk University", papers$affiliation)
papers$affiliation = gsub("Semmelweis Egyetem|Semmelweis University, Faculty of Medicine", "Semmelweis University of Budapest", papers$affiliation)
papers$affiliation = gsub("Shiraz University of Medical Sciences", "Shiraz University of Medical Science", papers$affiliation)
papers$affiliation = gsub("University of Silesia in Katowice", "University of Silesia", papers$affiliation)
papers$affiliation = gsub("St. Louis University|St. Louis University School of Medicine", "St Louis University", papers$affiliation)  
papers$affiliation = gsub('Universidade Estadual de Maringa', "State University of Maringá", papers$affiliation)
papers$affiliation = gsub('Universidade do Estado do Rio de Janeiro', "State University of Rio de Janeiro - UERJ", papers$affiliation)
papers$affiliation = gsub('Universiteit Stellenbosch', "Stellenbosch University", papers$affiliation)
papers$affiliation = gsub('Stockholms universitet|Stressforskningsinstitutet, Stockholms universitet', "Stockholm University", papers$affiliation)
papers$affiliation = gsub('Sun Yat-Sen University|Sun Yat-Sen University Cancer Center', "Sun Yat-sen University", papers$affiliation)
papers$affiliation = gsub("Universidad Politecnica de Madrid", "Technical University of Madrid", papers$affiliation)
papers$affiliation = gsub("Universidad Autonoma de Madrid, Facultad de Medicina","Universidad Autonoma de Madrid", papers$affiliation)
papers$affiliation = gsub("Technische Universitat Darmstadt", "Technische Universität Darmstadt", papers$affiliation)
papers$affiliation = gsub("TU Dortmund University", "Technische Universität Dortmund", papers$affiliation)
papers$affiliation = gsub("Technische Universitat Dresden", "Technische Universität Dresden", papers$affiliation)
papers$affiliation = gsub("Technische Universitat Kaiserslautern", "Technische Universität Kaiserslautern", papers$affiliation)
papers$affiliation = gsub("Technical University of Munich", "Technische Universität München", papers$affiliation)
papers$affiliation = gsub("Trinity College Dublin", "Trinity College Dublin, The University of Dublin", papers$affiliation)
papers$affiliation = gsub("Universite Grenoble Alpes|Grenoble Alps University", "Univ Grenoble Alpes", papers$affiliation)
papers$affiliation = gsub("UNESP-Universidade Estadual Paulista", "Universidade Estadual Paulista", papers$affiliation)
papers$affiliation = gsub('São Paulo Federal University (UNIFESP)', "Universidade Federal de São Paulo", papers$affiliation)
papers$affiliation = gsub("Universidade Federal de Vicosa", "Universidade Federal de Viçosa", papers$affiliation)
papers$affiliation = gsub("Federal University of Ceara|Universidade Federal do Ceara", "Universidade Federal do Ceará", papers$affiliation)
papers$affiliation = gsub("Universidade Federal do Parana", "Universidade Federal do Paraná", papers$affiliation)
papers$affiliation = gsub("Universidade Federal Fluminense" , "Universidade Federal Fluminense - UFF"  , papers$affiliation)
papers$affiliation = gsub("Universita Cattolica del Sacro Cuore|Universita Cattolica del Sacro Cuore, Rome|Universita Cattolica del Sacro Cuore, Rome, Facolta di Medicina e Chirurgia", "Università Cattolica del Sacro Cuore",papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Genova|Università degli Studi di Genova" , "University of Genoa", papers$affiliation)
papers$affiliation = gsub("Universita degli studi Magna Graecia di Catanzaro", 'Magna Græcia University', papers$affiliation)
papers$affiliation = gsub("Universita Campus Bio-Medico di Roma", "Campus Bio-Medico University", papers$affiliation)
papers$affiliation = gsub('Universita Bocconi','Bocconi University', papers$affiliation)
papers$affiliation = gsub("Universita degli Studi dell'Insubria", 'University of Insubria', papers$affiliation)
papers$affiliation = gsub("Universita degli Studi del Piemonte Orientale Amedeo Avogadro, Novara", 'University of Eastern Piedmont', papers$affiliation)
papers$affiliation = gsub('Hunter Medical Research Institute, Australia', 'University of Newcastle, Australia', papers$affiliation)
papers$affiliation = gsub("Universitat Hamburg", "Universität Hamburg", papers$affiliation)
papers$affiliation = gsub("Universita Politecnica delle Marche|Université Politecnica delle Marche" , "Università Politecnica delle Marche", papers$affiliation)
papers$affiliation = gsub("Universitat Politecnica de Catalunya" , "Universitat Politècnica de Catalunya" ,papers$affiliation)
papers$affiliation = gsub("Universitat Regensburg" , "Universität Regensburg" ,papers$affiliation)
papers$affiliation = gsub("Universite d' Auvergne Clermont-FD 1|Universite d'Auvergne, Faculte de Medecine Clermont-Ferrand" , "Université Clermont-Auvergne", papers$affiliation)
papers$affiliation = gsub("Universite de Franche-Comte" , "Université de Franche-Comté", papers$affiliation)
papers$affiliation = gsub("Universite de Nantes" , "Université de Nantes" ,papers$affiliation)
papers$affiliation = gsub("Universite de Sherbrooke" , "Université de Sherbrooke", papers$affiliation)
papers$affiliation = gsub("Universite Paul Sabatier Toulouse III", "Université Paul Sabatier" , papers$affiliation)
papers$affiliation = gsub("University at Buffalo, State University of New York", "University at Buffalo, The State University of New York", papers$affiliation)
papers$affiliation = gsub("Universite Francois-Rabelais Tours|Universite Francois Rabelais Faculte de Medicine", "University François Rabelais of Tours", papers$affiliation)
papers$affiliation = gsub("Universidade da Coruña|Complejo Hospitalario Universitario A Coruña|Complejo Hospitalario Universitario de A Coruña" , "University of A Coruña", papers$affiliation)
papers$affiliation = gsub("University at Albany State University of New York", "University of Albany, The State University of New York", papers$affiliation)
papers$affiliation = gsub("Universiteit Antwerpen|Universitair Ziekenhuis Antwerpen", "University of Antwerp", papers$affiliation)
papers$affiliation = gsub("Universidade de Aveiro", "University of Aveiro" ,papers$affiliation)
papers$affiliation = gsub("Universidad de Alcala" , "University of Alcalá" ,papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Bari" , "University of Bari Aldo Moro" ,papers$affiliation)
papers$affiliation = gsub("Universitat Basel|Universitatsspital Basel|Allgemeinchirurgische Klinik, Universitatsspital Basel" , "University of Basel", papers$affiliation)
papers$affiliation = gsub("Universitat Bern|UniversitatsSpital Bern|University of Bern, Institute of Pathology" , "University of Bern" ,papers$affiliation)
papers$affiliation = gsub("University of Arkansas for Medical Sciences" , "University of Arkansas for Medical Sciences, Little Rock",papers$affiliation)
papers$affiliation = gsub("University of Alabama School of Medicine|University of Alabama", "University of Alabama, Tuscaloosa"  ,papers$affiliation)
papers$affiliation = gsub("Universitat de Barcelona" , "University of Barcelona", papers$affiliation)
papers$affiliation = gsub("Alma Mater Studiorum Universita di Bologna" , "University of Bologna",papers$affiliation)
papers$affiliation = gsub("Universitat Bonn" , "University of Bonn",papers$affiliation)
papers$affiliation = gsub("Universite de Bordeaux" , "University of Bordeaux",papers$affiliation)
papers$affiliation = gsub("Universidade de Brasilia" , "University of Brasília - UnB",papers$affiliation)
papers$affiliation = gsub("Azienda Ospedaliero Universitaria di Cagliari|Azienda Ospedaliero Universitaria di Cagliari, Presidio Policlinico di Monserrato|Universita degli Studi di Cagliari" , "University of Cagliari",papers$affiliation)
papers$affiliation = gsub("Universita della Calabria" , "University of Calabria", papers$affiliation)
papers$affiliation = gsub("Campinas University|Universidade Estadual de Campinas" ,"University of Campinas" , papers$affiliation)
papers$affiliation = gsub("Universidad de Cantabria" , "University of Cantabria", papers$affiliation)
papers$affiliation = gsub("Carleton University" , "University of Carleton" , papers$affiliation)
papers$affiliation = gsub("Universidad de Castilla-La Mancha" , "University of Castilla-La Mancha", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Catania"  , "University of Catania", papers$affiliation)
papers$affiliation = gsub('Facultad de Medicina de la Universidad de Chile|Universidad de Chile' ,"University of Chile" , papers$affiliation)
papers$affiliation = gsub("Universitat zu Koln" , "University of Cologne", papers$affiliation)
papers$affiliation = gsub("University of Concepcion" , "University of Concepción", papers$affiliation)
papers$affiliation = gsub("CHU AP-HM Hôpital de la Conception (Marseille)", "Hôpital la Conception, Marseille", papers$affiliation)
papers$affiliation = gsub("Universidad de Cordoba, Facultad de Medicina|Universidad de Cordoba" , "University of Cordoba", papers$affiliation)
papers$affiliation = gsub("Debreceni Egyetem|Debreceni Egyetem Nepegeszsegugyi Kar" , "University of Debrecen", papers$affiliation)
papers$affiliation = gsub("Universitat Duisburg-Essen", "University of Duisburg-Essen", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Firenze", "University of Florence", papers$affiliation)
papers$affiliation = gsub("Gdanski Uniwersytet Medyczny", 'Gdańsk Medical University', papers$affiliation)
papers$affiliation = gsub("Hopitaux universitaires de Geneve|Universite de Geneve|Universite de Geneve Faculte de Medecine" , "University of Geneva", papers$affiliation)
papers$affiliation = gsub("Universitat de Girona" , "University of Girona", papers$affiliation)
papers$affiliation = gsub("Universitat Gottingen|Universitatsmedizin Gottingen|University Hospital of Géttingen" , "University of Göttingen", papers$affiliation)
papers$affiliation = gsub("Karl-Franzens-Universitat Graz|Medizinische Universitat Graz", "University of Graz", papers$affiliation)
papers$affiliation = gsub("Universitat Hohenheim|Universitét Hohenheim", "University of Hohenheim", papers$affiliation)
papers$affiliation = gsub('Medizinische Universitat Innsbruck' , 'Medical University of Innsbruck', papers$affiliation) # separate to Uni of Innsbruck
papers$affiliation = gsub("Universitat Konstanz", "University of Konstanz" , papers$affiliation)
papers$affiliation = gsub("Universita degli Studi dell'Aquila", "University of L'Aquila", papers$affiliation)
papers$affiliation = gsub("Universidad de Malaga", "University of Malaga", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Messina|Universita degli Studi di Messina, Facolta di Medicina e Chirurgia", "University of Messina", papers$affiliation)
papers$affiliation = gsub("Orthopaedics Department of Minho University|Universidade do Minho|Universidade do Minho, Escola de Ciencias da Saude" , "University of Minho", papers$affiliation)
papers$affiliation = gsub('Universite de Montpellier' , "University of Montpellier" , papers$affiliation)
papers$affiliation = gsub("Universidad de Murcia|Universidad de Murcia, Facultad de Medicina" , "University of Murcia", papers$affiliation)
papers$affiliation = gsub("Clinica Universitaria de Navarra|Universidad de Navarra" , "University of Navarra" , papers$affiliation)
papers$affiliation = gsub("Universite de Liege|Universite de Liege|Centre Hospitalier Universitaire de Liege" , "University of Liège" , papers$affiliation)
papers$affiliation = gsub("Universitat Lausanne Schweiz" , "University of Lausanne", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Milano - Bicocca", "University of Milano-Bicocca" , papers$affiliation)
papers$affiliation = gsub("^Universita degli Studi di Milano$" , "University of Milan", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Modena e Reggio Emilia"  , "University of Modena and Reggio Emilia", papers$affiliation)
papers$affiliation = gsub("Universitatsklinikum Munster|Westfalische Wilhelms-Universitat Munster" , "University of Münster", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Napoli Federico II" , "University of Naples Federico II", papers$affiliation)
papers$affiliation = gsub('University of Nevada School of Medicine' , "University of Nevada, Reno", papers$affiliation)
papers$affiliation = gsub("Universite Nice Sophia Antipolis" , "University of Nice Sophia Antipolis", papers$affiliation)
papers$affiliation = gsub("The University of North Carolina at Charlotte" , "University of North Carolina, Charlotte", papers$affiliation)
papers$affiliation = gsub("The University of North Carolina at Chapel Hill|University of North Carolina School of Medicine|University of North Carolina School of Dentistry|University of North Carolina Project-China" , "University of North Carolina, Chapel Hill", papers$affiliation)
papers$affiliation = gsub("University of North Texas Health Science Center" , "University of North Texas", papers$affiliation)
papers$affiliation = gsub("University of Notre Dame Australia" , "University of Notre Dame", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Padova|Universita degli Studi di Padova, Facolta di Medicina e Chirurgia" , "University of Padova" , papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Palermo", "University of Palermo", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Parma|Azienda Ospedaliero-Universitaria of Parma|Azienda Ospedaliero - Universitaria di Parma|Universita degli Studi di Parma, Facolta di Medicina e Chirurgia", "University of Parma", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Pavia", "University of Pavia", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Perugia", "University of Perugia", papers$affiliation)
papers$affiliation = gsub("Universite de Poitiers|Centre Hospitalier Universitaire de Poitiers", "University of Poitiers", papers$affiliation)
papers$affiliation = gsub("Universitat Potsdam", "University of Potsdam", papers$affiliation)
papers$affiliation = gsub('Universiteit van Pretoria', "University of Pretoria", papers$affiliation)
papers$affiliation = gsub("Universite du Quebec a Montreal", "University of Quebec at Montreal", papers$affiliation)
papers$affiliation = gsub("Universite de Rennes 1|Universite Rennes I Faculte de Medecine", "University of Rennes 1", papers$affiliation)
papers$affiliation = gsub("Universitat Rostock Uniklinikum und Medizinische Fakultat|Universitat Rostock|Universitätsmedizin Rostock" , "University of Rostock" , papers$affiliation)
papers$affiliation = gsub("Universidad de Salamanca|Hospital Universitario de Salamanca", "University of Salamanca" , papers$affiliation)
papers$affiliation = gsub("Universita di Salerno", "University of Salerno", papers$affiliation)
papers$affiliation = gsub("Universidad de Santiago de Compostela|Universidad de Santiago de Compostela, Facultad de Medicina", "University of Santiago de Compostela", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Sassari|University Hospital of Sassari" , "University of Sassari", papers$affiliation)
papers$affiliation = gsub("Universite de Strasbourg", "University of Strasbourg", papers$affiliation)
papers$affiliation = gsub("Universitat Stuttgart" , "University of Stuttgart", papers$affiliation)
papers$affiliation = gsub("University of Technology Sydney", "University of Technology, Sydney", papers$affiliation)
papers$affiliation = gsub("Universitat de les Illes Balears" , 'University of the Balearic Islands', papers$affiliation)
papers$affiliation = gsub("Universidade do Porto" , "University of Porto" , papers$affiliation)
papers$affiliation = gsub("Tokushima University|Tokushima University Hospital", "University of Tokushima", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Roma Tor Vergata", "University of Tor Vergata", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Trento", "University of Trento", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Trieste", "University of Trieste", papers$affiliation)
papers$affiliation = gsub("Universitat Tubingen|Universitatsklinikum Tubingen Medizinische Fakultat" , "University of Tübingen", papers$affiliation)
papers$affiliation = gsub("Turun yliopisto|Turun Yliopistollinen Keskussairaala" , "University of Turku", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Torino", "University of Turin", papers$affiliation)
papers$affiliation = gsub("Universitatsklinikum Ulm|Universitat Ulm" , "University of Ulm", papers$affiliation)
papers$affiliation = gsub("Universitat de Valencia, Facultad de Medicina y Odontologia|Universitat de Valencia", "University of Valencia", papers$affiliation)
papers$affiliation = gsub("Universidad de Valladolid|Hospital Universitario de Valladolid|Universidad de Valladolid, Facultad de Medicina" , "University of Valladolid", papers$affiliation)
papers$affiliation = gsub("Universita degli Studi di Verona|Universita degli Studi di Verona, Facolta di Medicina e Chirurgia" , "University of Verona", papers$affiliation)
papers$affiliation = gsub("Universitat Wien", "University of Vienna", papers$affiliation)
papers$affiliation = gsub("Medizinische Universitat Wien|Universitatsklinik fur Neurologie, Medical University of Vienna|Medical University of Vienna Institute of Cancer Research" , 'Medical University of Vienna', papers$affiliation)
papers$affiliation = gsub("Technische University of Vienna", "Vienna University of Technology", papers$affiliation)
papers$affiliation = gsub("Universidad de Vigo", "University of Vigo" , papers$affiliation)
papers$affiliation = gsub("Western Sydney University", "University of Western Sydney" , papers$affiliation)
papers$affiliation = gsub("Universidad de Zaragoza|Universidad de Zaragoza, Facultad de Medicina|Universidad de Zaragoza, Facultad de Veterinaria", "University of Zaragoza", papers$affiliation)
papers$affiliation = gsub("Universitat Zurich|University Hospital Zurich Neurologische Klinik|UniversitatsSpital Zurich|University of Zurich Brain Research Institute", "University of Zurich", papers$affiliation)
papers$affiliation = gsub("Uppsala Universitet", "Uppsala University", papers$affiliation)
papers$affiliation = gsub("Vilniaus universitetas", "Vilnius University" , papers$affiliation)
papers$affiliation = gsub("Vrije Universiteit Amsterdam", "VU University Amsterdam", papers$affiliation)
papers$affiliation = gsub("Wageningen University and Research Centre", "Wageningen University & Research", papers$affiliation)
papers$affiliation = gsub("Universite Paris Descartes", "University of Paris V - Paris Descartes", papers$affiliation)
papers$affiliation = gsub("Universite Paris-Sud XI", "University of Paris XI - Paris-Sud", papers$affiliation)
papers$affiliation = gsub("Universite Pierre et Marie Curie", "University of Paris VI - Pierre and Marie Curie", papers$affiliation)
papers$affiliation = gsub("Paris Diderot University|Universite Paris 7- Denis Diderot", "University of Paris VII - Paris Diderot", papers$affiliation)
papers$affiliation = gsub("Universite Paris 12 Val de Marne", "University of Paris XII - Paris-Est Créteil Val de Marne", papers$affiliation)
papers$affiliation = gsub('University of Texas at Dallas', "University of Texas, Dallas" , papers$affiliation)
papers$affiliation = gsub('University of Texas Health Science Center at San Antonio' , "University of Texas Health Science Center, San Antonio", papers$affiliation)
papers$affiliation = gsub('University of Texas at San Antonio' , "University of Texas, San Antonio", papers$affiliation)
papers$affiliation = gsub("University of Texas at Arlington", "University of Texas, Arlington", papers$affiliation)
papers$affiliation = gsub("UT Medical Branch at Galveston", "University of Texas Medical Branch at Galveston", papers$affiliation)
papers$affiliation = gsub("University of Texas at Dallas", "University of Texas, Dallas", papers$affiliation)
papers$affiliation = gsub("University of Texas Health Science Center at Houston|University of Texas School of Nursing at Houston", "University of Texas Health Science Center, Houston", papers$affiliation)
papers$affiliation = gsub("University of Colorado at Boulder|University of Colorado-Boulder School of Law", "University of Colorado, Boulder", papers$affiliation)
papers$affiliation = gsub('University of Colorado at Denver|University of Colorado at Denver Anschutz Medical Campus', "University of Colorado, Denver", papers$affiliation)
papers$affiliation = gsub('University of Nebraska Medical Center, College of Dentistry', 'University of Nebraska Medical Center', papers$affiliation)
papers$affiliation = gsub('University of Nebraska - Lincoln','University of Nebraska, Lincoln', papers$affiliation)
papers$affiliation = gsub('University of Missouri-St. Louis','University of Missouri, St. Louis', papers$affiliation)
papers$affiliation = gsub('University of Missouri-Columbia','University of Missouri, Columbia', papers$affiliation)
papers$affiliation = gsub('University of Missouri-Kansas City','University of Missouri, Kansas City', papers$affiliation)
papers$affiliation = gsub('Warwick Medical School|University of Warwick Medical School', 'University of Warwick', papers$affiliation)
papers$affiliation = gsub("Berlin Institute of Health","Charite - Universitatsmedizin Berlin", papers$affiliation)
papers$affiliation = gsub("York Health Economics Consortium", "University of York", papers$affiliation)
papers$affiliation = gsub("Beijing Tsinghua Changgeng Hospital", "Tsinghua University", papers$affiliation)
papers$affiliation = gsub('GlaxoSmithKline, USA|^c GSK$|^GSK$|GSK Vaccines|GSK Vaccines Institute for Global Health|GSK Nigeria|Present address: GSK', 'GlaxoSmithKline', papers$affiliation)
papers$affiliation = gsub('^Mayo$', 'Mayo Clinic', papers$affiliation)
# some changes made for Times Higher Ed:
papers$affiliation = gsub("Technische Universitét Ménchen|Technische Universität München", "Technical University of Munich", papers$affiliation)
papers$affiliation = gsub("Hong Kong University-Shenzhen Hospital|University of Hong Kong Li Ka Shing", 'University of Hong Kong', papers$affiliation)
papers$affiliation = gsub("University of New South Wales (UNSW) Australia|University of New South Wales, Rural Clinical School", "University of New South Wales", papers$affiliation)
papers$affiliation = gsub("Dartmouth-Hitchcock Medical Center|Dartmouth Institute for Health Policy and Clinical Practice|Geisel School of Medicine at Dartmouth|Tuck School of Business at Dartmouth", "Dartmouth College", papers$affiliation)
papers$affiliation = gsub("Universitat Mannheim|Universitatsklinikum Mannheim", 'University of Mannheim', papers$affiliation)
papers$affiliation = gsub('Rheinisch-Westfalische Technische Hochschule Aachen|Medizinische Fakultat und Universitats Klinikum Aachen', "RWTH Aachen University", papers$affiliation)
papers$affiliation = gsub("Universita di Pisa", "University of Pisa", papers$affiliation)
papers$affiliation = gsub("Technische Universitat Dresden", "Technische Universität Dresden", papers$affiliation) 
papers$affiliation = gsub("Universite Catholique de Louvain", "Université Catholique de Louvain" , papers$affiliation) 
papers$affiliation = gsub("Scuola Superiore Sant'Anna di Studi Universitari e di Perfezionamento", "Scuola Superiore Sant'Anna", papers$affiliation)
papers$affiliation = gsub("Universitatsklinikum Wurzburg", "Julius Maximilian University of Würzburg" , papers$affiliation)
#papers$affiliation = gsub()

# too many to change individually:
index = grep('Universidade de Coimbra', papers$affiliation)
papers$affiliation[index] = "University of Coimbra" 

# China medical split by country
index = papers$affiliation=='China Medical University' & papers$country=='Taiwan'
papers$affiliation[index] = 'China Medical University, Taiwan'

### Leiden affiliation merges, see http://www.leidenranking.com/information/universities
## l1) read in Leiden affilations
leiden = read_excel('CWTS Leiden Ranking 2018 - Affiliated institutions.xlsx', skip=1)
leiden = subset(leiden, `Relation type` %in% c('A','C'), select=c(-`Relation type`, -Country)) # exclude J = joint affiliations
# remove affiliations that map to multiple universities
tab = table(leiden$`Affiliated institution`)
to.remove = names(tab[tab>1])
index = leiden$`Affiliated institution` %in% to.remove
leiden = leiden[!index,]
# l2) merge Leiden and papers
papers = merge(papers, leiden, by.x='affiliation', by.y='Affiliated institution', all.x=T) 
# l3) overwrite affiliation 
index = is.na(papers$University) == F
papers$affiliation[index] = papers$University[index]

## blank some daft affiliations
index = papers$affiliation %in% unique( c('Research Unit','Research and Development Unit','Research and Development',
                                          'Patient Research Partner','Operational Research Unit',
                                          'Ministry of Health','Medical Affairs Department',
                                          'Independent Researcher','Independent Consultant','Division of Cardiology',
                                          'Division of Internal Medicine','Division of Cardiovascular Surgery',
                                          'College of Medicine','College of Nursing'
                                          'Chicago','London', 'UK', 'Prevention', 'Teaching', 'Faculty of Medicine', 'Cardiology', 'Cardiovascular Diseases', 'Research','Research Center', 'Epidemiology', 'Central', 'Office 2.47', 'Office 2.49', 'Central', 'Director', 'Medical Centre', 'San Francisco', 'Departments of Epidemiology',' Section of Neurosurgery', 'School of Dentistry', 'Private Dental Clinic', 'Private Clinic', 'University Medicine', 'School of Pharmacy', 'Engineering School',
                                          'School of Pharmacy','School of Psychology','School of Surgery','School of Nursing', "School of Public Health", "School of Clinical Sciences", "School of Medicine", "School of Food Science and Nutrition", "Medical School", 
                                          'Faculty of Medical and Health Sciences, School of Population Health',
                                          'Faculty of Health', 'Faculty of Pharmacy',
                                          'Faculty of Sciences', 'Faculty of Health Sciences',
                                          "Faculty of Pharmacy and Pharmaceutical Sciences", "Faculty of Health, Medicine, Nursing and Behavioural Science",
                                          "Faculty of Physical Education and Physiotherapy",
                                          'Private Practice Hygienist', 'School of Health Sciences',
                                          'Private Practice',
                                          'Private practice',
                                          'Private Practice Waldorf Dermatology and Laser Assoc. PC',
                                          'Private practice limited to periodontics and implant dentistry',
                                          'Private practice of orthodontics',
                                          'Private Practice in Athens',
                                          'Private Practice in Implant Prosthodontics',
                                          "Information Specialist (consultant)" , "Information Specialist Consultant",
                                          'Psychiatrist in Private Practice', 'Nephrology', 'Hull York'))
# DDS
# office affliations from https://www.idhjournal.com.au/article/S2468-0451(16)30018-9/pdf
papers$affiliation[index] = NA
#papers$affiliation = gsub(' & ', ' and ', papers$affiliation) # no longer used after Leiden merge
# remove medical schools ($ means end of string, ^ means start)
papers$affiliation = gsub('^School of Medicine, |^School of Medicine | Medical School$|, Medical School$| School of Medicine$|, School of Medicine$| School of Health Sciences$|, School of Health Sciences$| School of Medical Sciences$|, School of Medical Sciences$| School of Nursing$|, School of Nursing$|^Nursing School of |, School of Veterinary Medicine$|School of Veterinary Medicine$| School of Public Health$|, School of Public Health$| Dental School$|, Dental School$|^Faculty of Medicine | Faculty of Medicine$| Faculty of Medicine and Health Sciences$| Faculty of Medical Sciences$|, Faculty of Dentistry$|  Faculty of Pharmacy$|^Faculty of Medicine, | Faculty of Health$|, Faculty of Medical Sciences$|, Faculty of Kinesiology$|^Faculty of Health Sciences, |, Faculty of Medicine and Dentistry$| Faculty of Medicine and Dentistry$|, Faculty of Health Sciences$|, Faculty of Science| Faculty of Medical Sciences$| Faculty of Pharmacy$|, College of Medicine$| College of Medicine$', '', papers$affiliation)
# common hospital prefix in French
papers$affiliation = gsub('^Centre Hospitalier Universitaire ', 'Universitaire ', papers$affiliation)
# remove all 'The ' starts
papers$affiliation = gsub('^The ', '', papers$affiliation)

## search for duplicates
# e.g., "University of Cambridge, Institute of Public Health"
all = as.character(unique(papers$affiliation))
all = all[is.na(all)==F]
# only run once
find.matches = function(){
  matches = NULL
  #for (k in 1:length(all)){
  for (k in 201:1000){
    to.match = all[-k]
    match = stringdist(all[k], to.match, method='lcs') # longest common substring
    best.match = which(match==min(match))
    frame = data.frame(one=all[k], matched=to.match[best.match], type='lcs')
    matches = rbind(matches, frame)
    # b) small number of substitutions, so just the odd character change
    match = agrep(pattern=all[k], x=to.match, ignore.case=T, max.distance = list(substitutions=2, deletions=0, insertions=0)) 
    if(length(match)>0){
      frame = data.frame(one=all[k], matched=to.match[match], type='sub')
      matches = rbind(matches, frame)
    }
  }
} # end of function

## now combine matches (change to last name in list)
#(Universite de Rennes 1','University of Rennes') # badly reported, 1 or 2?
to.combine = list()
to.combine[[1]] = c("Centre Hospitalier Universitaire de Saint Etienne", "Universite Jean Monnet - Saint Etienne Faculte de Medecine Jacques Lisfranc", "Universite Jean Monnet Saint Etienne")
to.combine[[2]] = c("d Fédération de Médecine translationnelle de Strasbourg (FMTS)", "Fédération de Médecine Translationnelle de Strasbourg (FMTS)")
to.combine[[3]] = c('Pasteur Institute', "Institut Pasteur, Paris")
to.combine[[4]] = c("Universidad San Sebastién","Universidad San Sebastian", "Universidad San Sebastiá N","Universidad San Sebastian")
to.combine[[5]] = c('Université Paris Est (UPEC)','Universite Paris-Est')
to.combine[[6]] = c("ICPS Institut CardioVasculaire Paris-Sud", "Faculte de Medecine Paris-Sud", "University of Paris XI - Paris-Sud")
to.combine[[7]] = c('Fire Brigade of Paris','Brigade de Sapeurs Pompiers de Paris (BSPP)')
to.combine[[8]] = c('Union South-East Asia Office','International Union Against Tuberculosis and Lung Disease (The Union)','International Union Against Tuberculosis and Lung Disease')
to.combine[[9]] = c("Instituto de Investigación Sanitaria de Navarra (IdiSNA)", "Navarra's Health Research Institute (IDISNA)", "Navarra Institute for Health Research (IdiSNA)"  )
to.combine[[10]] = c('Centre Hospitalier Universitaire de Clermont-Ferrant','Centre Hospitalier Universitaire de Clermont-Ferrand')
to.combine[[11]] = c('Hopital Haut-Leveque C.H.U de Bordeaux','CHU Hopitaux de Bordeaux')
to.combine[[12]] = c("Centre Hospitalier Universitaire de Nice, Hopital l'Archet",'Centre Hospitalier Universitaire de Nice')
to.combine[[13]] = c("Fonds de la Recherche Scientifique-FNRS",'Fonds de la Recherche Scientifique - FNRS')
to.combine[[14]] = c("Hotel Dieu CHU de Nantes","Hôpital de Nantes")
to.combine[[15]] = c("Société française d'arthroscopie junior (SFAJ) sous l’égide de la SFA","Société française d'arthroscopie Junior (SFAJ)")
to.combine[[16]] = c('Universite de Reims Champagne-Ardenne UFR de Medicine','Universit ï¿½ de Reims Champagne-Ardenne','Universite de Reims Champagne-Ardenne')
to.combine[[17]] = c('Universitätsmedizin Greifswald','University Medicine Greifswald')
to.combine[[18]] = c('Osaka University Faculty of Medicine','Osaka University')
to.combine[[19]] = c('Dresden University Faculty of Medicine and University Hospital Carl Gustav Carus','Dresden University')
to.combine[[20]] = c('Umea University, Faculty of Medicine','Umea University','Umeå University')
to.combine[[21]] = c('Ruhr-Universitat Bochum','University of Bochum')
to.combine[[22]] = c('German Center for Diabetes Research','German Center for Diabetes Research (DZD)')
to.combine[[23]] = c('Bayer Pharma AG','Bayer AG')
to.combine[[24]] = c('Universitatsklinikum Schleswig-Holstein Campus Lubeck', 'Universitatsklinikum Schleswig-Holstein Campus Kiel', 'Universitatsklinikum Schleswig-Holstein')
to.combine[[25]] = c('University of Cambridge, Institute of Public Health','University of Cambridge, School of Clinical Medicine','University of Cambridge')
to.combine[[26]] = c("School of Medicine, University of Auckland", "University of Auckland")
to.combine[[27]] = c("Hebrew University-Hadassah Medical School", "Hebrew University")
to.combine[[28]] =c("Yale", "Yale University")
to.combine[[29]] =c("Johns Hopkins", "Johns Hopkins Medicine", "John Hopkins University-MCC", "Johns Hopkins Bloomberg", "Wilmer Eye Institute at Johns Hopkins", "Johns Hopkins Medical Institutions", "Johns Hopkins University")
to.combine[[30]] =c("Harvard" , "Harvard School of Dental Medicine", "Harvard Chan", "Harvard University")
to.combine[[31]] =c("David Geffen School of Medicine at UCLA", "UCLA Fielding", "UCLA School of Dentistry", "UCLA Health System", "University of California, Los Angeles")
to.combine[[32]] =c("Rutgers School of Dental Medicine", "Rutgers Biomedical and Health Sciences", "Rutgers New Jersey Medical School Neurological Institute of New Jersey", "Rutgers University-Newark Campus", "Rutgers, The State University of New Jersey")
to.combine[[33]] =c("Touro University - California", "Touro University")
to.combine[[34]] =c("Nagoya City University Graduate School of Medical Sciences" , 'Nagoya City University')                                  
to.combine[[35]] =c("Graduate School of Agricultural and Life Sciences The University of Tokyo", 'University of Tokyo Hospital', 'University of Tokyo')
to.combine[[36]] =c("Kumamoto University", "Kumamoto University")
to.combine[[37]] =c("University of Thessaly, School of Health Sciences" , 'University of Thessaly')
to.combine[[38]] =c("National and Kapodistrian University of Athens, School of Health Sciences", 'National and Kapodistrian University of Athens')
to.combine[[39]] =c("Ribeirão Preto School of Dentistry/ São Paulo University", 'São Paulo University', "Universidade de Sao Paulo - USP", "University of Séo Paulo (Universidade de Séo Paulo - USP)","University of Séo Paulo (FMRP-USP)","USP-Universidade de Séo Paulo","University of São Paulo" )
to.combine[[40]] =c("Santa Casa School of Medical Sciences", "Santa Casa School of Medicine", "Santa Casa Medical Sciences School")
to.combine[[41]] =c("IMED Faculdade Meridional", "School of Dentistry - Faculdade Meridional IMED", "IMED")
to.combine[[42]] =c("Lund University, School of Economics and Management", "Lund University")
to.combine[[43]] =c("Affiliated DrumTower Hospital of Nanjing University Medical School", "Nanjing University")
to.combine[[44]] =c("Central South University China School of Basic Medical Sciences","Central South University")
to.combine[[45]] =c("Nursing School of Kunming Medical University", "Kunming Medical University")
to.combine[[46]] =c("Binzhou Medical University School of Nursing", "Binzhou Medical University")
to.combine[[47]] =c("Muğla Sıtkı Koçman University School of Health Department of Health Care Management", "Muğla Sıtkı Koçman University")
to.combine[[48]] =c("School of Medical Sciences - Universiti Sains Malaysia", 'Universiti Sains Malaysia')
to.combine[[49]] =c("University College Cork Dental School and Hospital", 'University College Cork') 
to.combine[[50]] =c("McMaster University, DeGroote School of Business", 'McMaster University Medical Centre', "McMaster University")
to.combine[[51]] =c("Indiana University", 'Indiana University, Bloomington')
to.combine[[52]] =c("University of Pennsylvania, School of Veterinary Medicine" , "University of Pennsylvania, Wharton School", 'University of Pennsylvania, Annenberg School for Communications','University of Pennsylvania, Health System','University of Pennsylvania, School of Dental Medicine','University of Pennsylvania')
to.combine[[53]] =c("Lewis Katz School of Medicine at Temple University", "Temple University’s School of Social Work", "Temple University, Kornberg School of Dentistry", "Temple University’s Fox School of Business", 'Temple University')
to.combine[[54]] =c('Texas A and M University','Texas A and M Health Science Center','Texas A and M AgriLife Research and Extension Center','Texas A&M University')
to.combine[[55]] =c('University of Texas M. D. Anderson Cancer Center', "University of Texas MD Anderson Cancer Center")
to.combine[[56]] =c('UT Southwestern', 'UT Southwestern Medical Center')
to.combine[[57]] =c('Texas Tech University Health Sciences Center at El Paso','Texas Tech University Health Sciences Center at Lubbock','Texas Tech University at Lubbock','Texas Tech University Health Science Center','Texas Tech University Health Sciences Center-Permian Basin in Odessa','Texas Tech University')
to.combine[[58]] =c("University of Washington School of Public Health and Community Medicine", "University of Washington, Medicine", "University of Washington Medical Center", 'University of Washington', "University of Washington, Seattle")
to.combine[[59]] =c("George Washington University School of Medicine and Health Sciences", 'George Washington University')
to.combine[[60]] =c("Cooper Medical School of Rowan University",'Rowan University')
to.combine[[61]] =c("West Virginia University School of Medicine Morgantown", 'West Virginia University Robert C. Byrd Health Sciences Center', "West Virginia University")
to.combine[[62]] =c("Edinburgh Medical School, Centre for Reproductive Biology", "Edinburgh Medical School, MRC Centre for Inflammation Research", "Edinburgh Medical School")
to.combine[[63]] =c("University of Cambridge, School of Clinical Medicine","University of Cambridge")
to.combine[[64]] =c('Exercise Physiology La Trobe Rural Health School', 'La Trobe University')
to.combine[[65]] =c("University of Sheffield, School of Medicine and Biomedical Sciences" , "University of Sheffield" )
to.combine[[66]] =c("University of Pittsburgh Graduate", 'University of Pittsburgh Medical Center','University of Pittsburgh Medical Center, Magee-Womens Hospital',"University of Pittsburgh Medical Center, Children's Hospital of Pittsburgh","University of Pittsburgh")
to.combine[[67]] =c("Indiana University School of Medicine Indianapolis", 'Indiana University School of Dentistry', 'Indiana University School of Nursing Indianapolis','Indiana University Center for Aging Research', 'Indiana University Northwest', "Indiana University")
to.combine[[68]] =c("Tulane University School of Public Health and Tropical Medicine", "Tulane University")
to.combine[[69]] =c('University of Wisconsin Madison','University of Wisconsin, Madison')
to.combine[[70]] =c('University of Wisconsin Milwaukee','University of Wisconsin, Milwaukee')
to.combine[[71]] =c("Faculty of Medicine, Ramathibodi Hospital, Mahidol University", "Mahidol University")
to.combine[[72]] =c("Malmo University Faculty of Odontology", 'Malmo University Hospital', 'University of Malmé','University of Malmé',"Malmo University")
to.combine[[73]] =c("Dresden University Faculty of Medicine and University Hospital Carl Gustav Carus", "Dresden University")
to.combine[[74]] =c("King Chulalongkorn Memorial Hospital, Faculty of Medicine Chulalongkorn University", "Chulalongkorn University")
to.combine[[75]] =c("University of Lisbon Faculty of Medicine, Institute of Molecular Medicine", 'University of Lisbon')
to.combine[[76]] =c("UCL Eastman Dental Institute", "UCL Institute of Child Health", "UCL School of Pharmacy", "UCL Institute of Education", "UCL Institute of Ophthalmology", "UCL Institute of Cognitive Neuroscience", "UCL School of Pharmacy", 'UCL')
to.combine[[77]] =c("UCSF School of Dentistry", "USCF", "University of California, San Francisco")
to.combine[[78]] =c("Oxford University Clinical Research Unit", "University of Oxford Medical Sciences Division", "University of Oxford")
to.combine[[79]] =c("University of Iowa Carver College of Medicine", 'University of Iowa Carver', 'University of Iowa Hospitals and Clinics', 'University of Iowa Healthcare','University of Iowa College of Dentistry',"University of Iowa")
to.combine[[80]] =c("Albert Einstein College of Medicine of Yeshiva University", "Yeshiva University")
to.combine[[81]] =c('University Cincinnati College of Medicine','University of Cincinnati Academic Health Center', "University of Cincinnati College of Medicine", 'University of Cincinnati Academic Health Center','University Cincinnati','University of Cincinnati')
to.combine[[82]] =c("University of Dundee College of Medicine, Dentistry and Nursing", 'University of Dundee')
to.combine[[83]] =c("University of Edinburgh, College of Medicine and Veterinary Medicine", 'University of Edinburgh')
to.combine[[84]] =c("Michigan State University, College of Human Medicine" , 'Michigan State University')
to.combine[[85]] =c("Molecular and Behavioral Neuroscience Institute, University Michigan Ann Arbor", 'University of Michigan Health System', 'University of Michigan Hospital', 'University Michigan Ann Arbor', 'University of Michigan-Flint', 'University of Michigan School of Dentistry', 'University of Michigan Comprehensive Cancer Center', 'University of Michigan')
to.combine[[86]] =c("University of Arizona College of Nursing", 'University of Arizona Cancer Center','University of Arizona')
to.combine[[87]] =c("King Saud University Medical College","King Saud University College of Applied Medical Sciences","King Saud University")
to.combine[[88]] =c("Imperial College", "Imperial College London")
to.combine[[89]] =c("UCL", "University College London")
to.combine[[90]] =c("University of Queensland, Centre for Clinical Research", "University of Queensland")
to.combine[[91]] =c("Children's Hospital At Westmead, Centre for Kidney Research" , "Children's Hospital At Westmead")
to.combine[[92]] =c('McGill University, Douglas Mental Health University Institute','McGill University, Montreal Neurological Institute and Hospital', "McGill University Health Centre, Montreal General Hospital", "McGill University Health Centre, Montreal", "McGill University") 
to.combine[[93]] =c("Biomedical Research Centre in Mental Health Network (CIBERSAM) G16", "Biomedical Research Centre in Mental Health Network (CIBERSAM) G10", "Biomedical Research Centre in Mental Health Network (CIBERSAM)")                
to.combine[[94]] =c("University of Newcastle upon Tyne,", "Newcastle University, United Kingdom", "University of Newcastle") # comma in first is sic              
to.combine[[95]] =c('Academic Medical Centre, University of Amsterdam','University of Amsterdam')
to.combine[[96]] =c("Mayo Clinic Scottsdale-Phoenix, Arizona", "Mayo Clinic Hospital", "Mayo Graduate School", "Mayo Clinic in Jacksonville, Florida", "Mayo Clinic")
to.combine[[97]] =c("UNSW, National Drug and Alcohol Research Centre", "UNSW, National Drug & Alcohol Research Centre", "UNSW Australia", "University of New South Wales (UNSW) Australia", "University of New South Wales") # would prefer 'Australia' tag, but kept with Leiden
to.combine[[98]] =c('University of Ottawa Heart Institute', 'University of Ottawa, Canada', 'University of Ottawa') 
to.combine[[99]] =c("Columbia University Division of Cardiology", "Columbia University in the City of New York", "Columbia University, College of Physicians and Surgeons", "Columbia University Medical Center", "Columbia University Division of Cardiac Surgery", "Columbia University College of Dental Medicine", "Columbia University")
to.combine[[100]] =c("Tel Aviv University, Sackler", "Tel Aviv University")
to.combine[[101]] =c('Hofstra North Shore-Long Island Jewish','North Shore-Long Island Jewish Health System')
to.combine[[102]] =c('Mercer University at Atlanta','Mercer University')
to.combine[[103]] =c('Lorraine University','Université de Lorraine')
to.combine[[104]] =c('Dresden University','Technische Universitat Dresden')
to.combine[[105]] =c('University Heart Center Freiburg', "Universitat Freiburg im Breisgau", 'University of Freiburg')
to.combine[[106]] =c('University Hospital of the Paracelsus Medical University Salzburg','Paracelsus Medical University')
to.combine[[107]] =c('Monash University Malaysia','Monash University')
to.combine[[108]] =c('Macquarie University, Australian School of Advanced Medicine', 'Macquarie University')
to.combine[[109]] =c('Flinders University of South Australia','Flinders University')
to.combine[[110]] =c('Charles Sturt University, Wagga Wagga','Charles Sturt University')
to.combine[[111]] =c('Gold Coast University Hospital Southport','Gold Coast Hospital')
to.combine[[112]] =c('King Saud University College of Pharmacy','King Saud University')
to.combine[[113]] =c('University of Nottingham Malaysia Campus','University of Nottingham')
to.combine[[114]] =c('University of Strathclyde Institute of Global Public Health at iPRI','University of Strathclyde Institute of Global Public Health at the International Prevention Research Institute','University of Strathclyde')
to.combine[[115]] =c('University of Kentucky College of Pharmacy','University of Kentucky HealthCare',"University of Kentucky Children's Hospital",'University of Kentucky')
to.combine[[116]] =c('University of Southern Denmark, Esbjerg','University of Southern Denmark, Sonderborg','University of Southern Denmark')
to.combine[[117]] =c('Duke University Health System','Duke University')
to.combine[[118]] =c('Northwestern University Feinberg','Northwestern University')
to.combine[[119]] =c('Ohio State University Comprehensive Cancer Center','Ohio State University')
to.combine[[120]] =c('Marquette University School of Dentistry','Marquette University')
to.combine[[121]] =c('University of British Columbia Okanagan','University of British Columbia')
to.combine[[122]] =c('Louisiana State University in Shreveport','Louisiana State University')
to.combine[[123]] =c('University of Connecticut Health Center','University of Connecticut')
to.combine[[124]] =c('University of Virginia Health System','University of Virginia')
to.combine[[125]] =c('Stanford University Medical Center','Stanford University')
to.combine[[126]] =c('University of Alabama, Birmingham','University of Alabama at Birmingham')
to.combine[[127]] =c('Tufts University School of Dental Medicine','Tufts University')
to.combine[[128]] =c('West Virginia University Robert C. Byrd Health Sciences Center','West Virginia University')
to.combine[[129]] =c('Washington State University Vancouver','Washington State University Pullman','Washington State University')
to.combine[[130]] =c('Washington University School of Medicine in St. Louis','Washington University in St. Louis','Washington University, St. Louis')
to.combine[[131]] =c('Warren Alpert Medical School of Brown University','Brown University Center for Alcohol and Addiction Studies','Brown University')
to.combine[[132]] =c('University of Maryland School of Social Work','University of Maryland Medical Center','University of Maryland Medical System',"University of Maryland", 'University of Maryland, College Park') # this is separate: 'University of Maryland, Baltimore'
to.combine[[133]] =c('Oregon Health and Science University Knight Cardiovascular Institute','Oregon Health and Science University')
to.combine[[134]] =c('Oklahoma State University System','Oklahoma State University Medical Center','Oklahoma State University - Center for Health Sciences','Oklahoma State University','Oklahoma State University - Stillwater')
to.combine[[135]] =c('Rush University Medical Center','Rush University College of Nursing','Rush University')
to.combine[[136]] =c('Vanderbilt University Medical Center','Vanderbilt University')
to.combine[[137]] =c('Loyola University Medical Center','Loyola University Stritch','Loyola University Chicago')
to.combine[[138]] =c('University of North Carolina School of Dentistry','University of North Carolina at Chapel Hill','University of North Carolina System','University of North Carolina at Greensboro','University of North Carolina at Charlotte','University of North Carolina Wilmington','University of North Carolina Project-China','University of North Carolina')
to.combine[[139]] =c("University of North Dakota School of Medicine and Health Sciences", 'University of North Dakota')
to.combine[[140]] =c("University of Western Australia Faculty of Medicine and Dentistry", "University of Western Australia")
to.combine[[141]] =c('University of Southern California/Norris Comprehensive Cancer Center','University of Southern California')
to.combine[[142]] =c('Baylor University Medical Center at Dallas','Baylor University')
to.combine[[143]] =c('University of Utah Health Sciences','University of Utah Health','University of Utah')
to.combine[[144]] =c('University of New Mexico Health Sciences Center','University of New Mexico')
to.combine[[145]] =c('Virginia Commonwealth University Health System','Virginia Commonwealth University')
to.combine[[146]] =c('Thomas Jefferson University Hospital','Thomas Jefferson University')
to.combine[[147]] =c("Purdue University Weldon School of Biomedical Engineering", "Purdue University, Lafayette")
to.combine[[148]] =c('Islamic Azad University, Lahijan Branch','Islamic Azad University, Science and Research Branch','Islamic Azad University, Tehran Medical Branch','Islamic Azad University, Tehran Dental Branch','Islamic Azad University')
to.combine[[149]] =c('University of Miami Leonard M. Miller','University of Miami')
to.combine[[150]] =c('University of Florida College of Dentistry','University of Florida')
to.combine[[151]] =c('Georgetown University Hospital','Georgetown University Medical Center','Georgetown University')
to.combine[[152]] =c('University of Louisville Health Sciences Center','University of Louisville')
to.combine[[153]] =c('Weill Cornell Medical College','Weill Cornell Medicine Feil Family Brain and Mind Research Institute','Weill Cornell Medicine','Weill Cornell Medical Center','Weill Cornell Medicine-Qatar','Weill Cornell','Weill Cornell Medical College')
to.combine[[154]] =c('Creighton University School of Pharmacy and Health Professions','Creighton University Medical Center','Creighton University')
to.combine[[155]] =c('Marshall University Joan C. Edwards','Marshall University')
to.combine[[156]] =c("Universidad Autonoma de Barcelona, Facultad de Medicina", "Universitat Auténoma de Barcelona","Universitat Autònoma de Barcelona" )
to.combine[[157]] =c('Touro University - Nevada','Touro University')
to.combine[[158]] =c('Archbold Medical Group/Florida State University','Florida State University')
to.combine[[159]] =c('University of Illinois at Chicago','University of Illinois at Urbana-Champaign','University of Illinois')
to.combine[[160]] =c('Arizona State University at the Downtown Phoenix Campus','Arizona State University')
to.combine[[161]] =c('University of Rochester School of Medicine and Dentistry','University of Rochester Medical Center','University of Rochester')
to.combine[[162]] =c('University of Chicago Pritzker','NORC at the University of Chicago','University of Chicago')
to.combine[[163]] =c('University of Kansas School of Medicine - Wichita', 'University of Kansas Lawrence', 'University of Kansas Medical Center', 'University of Kansas')  
to.combine[[164]] =c('University of Massachusetts Lowell','University of Massachusetts System','University of Massachusetts Boston','University of Massachusetts','University of Massachusetts Amherst')
to.combine[[165]] =c('Northeastern University','Northeastern University China')
to.combine[[166]] =c('Purdue University Calumet','Purdue University')
to.combine[[167]] =c('Rocky Mountain University of Health Care Professions','Rocky Mountain University of Health Professions')
to.combine[[168]] =c("North China University of Science and Technology Affiliated Hospital", "North China University of Science and Technology")
to.combine[[169]] =c('University of Mississippi Medical Center','University of Mississippi')
to.combine[[170]] =c('University of Toledo Medical Center','University of Toledo')
to.combine[[171]] =c('Colorado State University-Pueblo','Colorado State University')
to.combine[[172]] =c("University of Hawaii at Manoa","University of Hawaii System","University of Hawaii at Manoa John A. Burns",'University of Hawaii',"University of Hawaii, Manoa")
to.combine[[173]] =c('A.T. Still University, Kirksville','A.T. Still University')
to.combine[[174]] =c('University of Minnesota Medical Center, Fairview','University of Minnesota Twin Cities','University of Minnesota','University of Minnesota System') # 
to.combine[[175]] =c('University of Missouri System','University of Missouri') 
to.combine[[176]] =c("St. Luke's University Health Network","St. Luke's University Hospital")
to.combine[[177]] =c('California State University Monterey Bay','California State University Long Beach','California State University Dominguez Hills','California State University Fullerton','California State University')
to.combine[[178]] =c('Montana State University - Bozeman','Montana State University')
to.combine[[179]] =c('University of South Florida Tampa','University of South Florida Health','University of South Florida St. Petersburg', 'University of South Florida')
to.combine[[180]] =c("Saint Michael's Hospital University of Toronto","University Health Network University of Toronto","Hospital for Sick Children University of Toronto","Mount Sinai Hospital of University of Toronto","Princess Margaret Hospital University of Toronto","Toronto Health Economics and Technology Assessment Collaborative University of Toronto","Toronto Western Hospital University of Toronto","Ontario Cancer Institute University of Toronto","Lunenfeld-Tanenbaum Research Institute of University of Toronto","Toronto Western Research Institute University of Toronto","Toronto General Research Institute University of Toronto","University of Toront","Li Ka Shing Knowledge Institute","University of Toronto")
to.combine[[181]] =c('University of Alberta Hospital','University of Alberta')
to.combine[[182]] =c('University of Saskatchewan, Western College of Veterinary Medicine','University of Saskatchewan')
to.combine[[183]] =c('University of Prince Edward Island Atlantic Veterinary College','University of Prince Edward Island')
to.combine[[184]] =c('King Abdulaziz University Hospital Jeddah','King Abdulaziz University')
to.combine[[185]] =c('Kobenhavns Universitet','Copenhagen Centre for Disaster Research','Copenhagen University Hospital','University of Copenhagen')
to.combine[[186]] =c('Keio University Hospital','Keio University')
to.combine[[187]] =c('Teikyo University Hospital','Teikyo University')
to.combine[[188]] =c('Kyoto University Hospital','Kyoto University')
to.combine[[189]] =c('University of Mie','Mie University Hospital','Mie University')
to.combine[[190]] =c('Hiroshima University Hospital','Hiroshima University')
to.combine[[191]] =c('Saitama Medical University Hospital','Saitama Medical Center, Saitama Medical University','Saitama Medical University')
to.combine[[192]] =c('Nagoya City University Hospital','Nagoya City University Graduate','Nagoya City University')
to.combine[[193]] =c('Yokohama City University Hospital','Yokohama City Graduate','Yokohama City University')
to.combine[[194]] =c('Shinshu University Hospital','Shinshu University Faculty of Medicine','Shinshu University')
to.combine[[195]] =c('Tokushima University Hospital','Tokushima University')
to.combine[[196]] =c('Tottori University Hospital','Tottori University')
to.combine[[197]] =c('Kitasato University Hospital','Kitasato University')
to.combine[[198]] =c('Hokkaido University Hospital','Hokkaido University')
to.combine[[199]] =c('Juntendo University Shizuoka Hospital','Juntendo University')
to.combine[[200]] =c('Kyushu Dental University','Kyushu University')
to.combine[[201]] =c('EHFRE International University/ FUCSO','EHFRE International University')
to.combine[[202]] =c('Artesis Plantijn University','Artesis Plantijn University College')
to.combine[[203]] =c('University of Nairobi College of Health Sciences','University of Nairobi')
to.combine[[204]] =c('University Hospital of Athens','University of Athens')
to.combine[[205]] =c('University Hospital of Ioannina','University of Ioannina')
to.combine[[206]] =c('Urmia University of Medical Sciences','Urmia University')
to.combine[[207]] = c("Università degli Studi di Roma \"Foro Italico\"", "Universita degli Studi di Roma Tor Vergata","Universita degli Studi di Roma La Sapienza", "Sapienza University of Rome")
to.combine[[208]] =c('UNIGRANRIO','UNIGRANRIO University','Grande Rio University (UNIGRANRIO)')
to.combine[[209]] =c('University of Séo Paulo (Universidade de Séo Paulo - USP)','USP-Universidade de Séo Paulo','University of Séo Paulo (FMRP-USP)','University of Séo Paulo')
to.combine[[210]] =c('VU University Medical Center, Institute for Cardiovascular Research VU','VU University Medical Center')
to.combine[[211]] =c('University Hospital Maastricht','Maastricht University')
to.combine[[212]] =c('University of Groningen, University Medical Center Groningen','University of Groningen')
to.combine[[213]] =c('Erasmus University Medical Center','Erasmus MC Cancer Institute','Erasmus University Rotterdam')
to.combine[[214]] =c('Leiden University Medical Center - LUMC','Leiden University')
to.combine[[215]] =c('Radboud University Nijmegen Medical Centre','Radboud University Medical Center','Radboud UMC Nijmegen','Radboud University Nijmegen')
to.combine[[216]] =c('Karakter Child and Adolescent Psychiatry University Centre','Karakter Child and Adolescent Psychiatry')
to.combine[[217]] =c('Karolinska University Hospital','Karolinska Institutet')
to.combine[[218]] =c('Linnaeus University, Vaxjo','Linnaeus University, Kalmar','Linnaeus University')
to.combine[[219]] =c('Sun Yat-Sen University Cancer Center','Sun Yat-Sen University')
to.combine[[220]] =c('Fudan University Shanghai Medical College','Fudan University Shanghai Cancer Center','Fudan University')
to.combine[[221]] =c('Central South University China','Central South University')
to.combine[[222]] =c('Daping Hospital, the Third Military Medical University','Third Military Medical University')
to.combine[[223]] =c('Hospital of Nanjing Medical University','Nanjing Medical University')
to.combine[[224]] =c('Peking University Health Science Center','Peking University')
to.combine[[225]] =c('Third Affiliated Hospital of Soochow University','Soochow University')
to.combine[[226]] =c('First Affiliated Hospital of Kunming Medical University','1st Affiliated Hospital of Kunming Medical University','Second Affiliated Hospital of Kunming Medical University','Kunming Medical University')
to.combine[[227]] =c('Shantou University, Medical College (SUMC)','Shantou University')
to.combine[[228]] =c('First Affiliated Hospital of Jinzhou Medical University','Jinzhou Medical University')
to.combine[[229]] =c('First Affiliated Hospital of Zhengzhou University','Zhengzhou University')
to.combine[[230]] =c('Affiliated Hospital of Guangdong Medical University','Hospital of Guangdong Medical University','Guangdong Medical University')
to.combine[[231]] =c('Affiliated Hospital of Guangzhou Medical University','First Affiliated Hospital of Guangzhou Medical University','Third Affiliated Hospital of Guangzhou Medical University','Guangzhou Medical University')
to.combine[[232]] =c('Second Affiliated Hospital of Harbin Medical University','First Affiliated Hospital of Harbin Medical University','Harbin Medical University')
to.combine[[233]] =c('Affiliated Hospital of Zunyi Medical University','Third Affiliated Hospital of Zunyi Medical University','Zunyi Medical University')
to.combine[[234]] =c('Tangdu Hospital, Fourth Military Medical University','Fourth Military Medical University')
to.combine[[235]] =c('Affiliated Hospital of Guizhou Medical University','Affiliated Baiyun Hospital of Guizhou Medical University','Guizhou Medical University')
to.combine[[236]] =c("Wenzhou Medical University Affiliated Cixi Hospital","Second Affiliated Hospital and Yuying Children's Hospital of Wenzhou Medical University","Yuying Children's Hospital of Wenzhou Medical University","First Affiliated Hospital of Wenzhou Medical University","Second Affiliated Hospital of Wenzhou Medical University","Wenzhou Medical University")
to.combine[[237]] =c('Gansu University of Traditional Chinese Medicine','Gansu University of Chinese Medicine')
to.combine[[238]] =c('Affiliated Hospital of Binzhou Medical University','Binzhou Medical University Hospital Outpatient Department','Binzhou Medical University Hospital','Binzhou Medical University')
to.combine[[239]] =c("Affiliated Hospital of Inner Mongolia Medical University","Second Affiliated Hospital to Inner Mongolia Medical University","Traditional Chinese Medicine Institute of Inner Mongolia Medical University","Second Affiliated Hospital of Inner Mongolia Medical University","First Affiliated Hospital of Inner Mongolia Medical University","Affiliated Cancer Hospital of Inner Mongolia Medical University","Inner Mongolia Medical University")
to.combine[[240]] =c("North China University of Science and Technology Affiliated Hospital","Trauma Laboratory of the North China University of Science and Technology","North China University of Science and Technology")
to.combine[[241]] =c("First Affiliated Hospital of Gannan Medical University","Gannan Medical University Pingxiang Hospital","Gannan Medical University")
to.combine[[242]] =c("University of Applied Sciences and Arts Western Switzerland Valais","University of Applied Sciences and Arts Western Switzerland Valais (HES-SO Valais-Wallis)","University of Applied Sciences and Arts Western Switzerland")
to.combine[[243]] =c("Faculdade de Ciencias e Tecnologia, New University of Lisbon",'New University of Lisbon')
to.combine[[244]] =c('Arctic University of Norway','UiT The Arctic University of Norway')
to.combine[[245]] =c('Bjørknes College','Bjørknes University College')
to.combine[[246]] =c('Univesrsity of Benin Teaching Hospital','University of Benin')
to.combine[[247]] =c('Obafemi Awolowo University Teaching Hospitals Complex','Obafemi Awolowo University')
to.combine[[248]] =c('Hanyang University Guri Hospital','Hanyang University')
to.combine[[249]] =c("Seoul National University Bundang Hospital","Seoul National University Hospital","SMG- Seoul National University Boramae Medical Center","Seoul National University")
to.combine[[250]] =c('Inha University, Incheon','Inha University')
to.combine[[251]] =c('Korea University Medical Center','Korea University')
to.combine[[252]] =c('Yonsei University Health System','Yonsei University, Wonju','Yonsei University Wonju Campus','Yonsei University')
to.combine[[253]] =c('Ulsan University','University of Ulsan, College of Medicine','University of Ulsan')
to.combine[[254]] =c('Gyeongsang National University (GSNU)','Gyeongsang National University')
to.combine[[255]] =c('Dongguk University, Gyeongju','Dongguk University, Seoul','Dongguk University Ilsan Hospital','Dongguk University')
to.combine[[256]] =c('Hallym University Medical Center','Hallym University')
to.combine[[257]] =c('Inje University Paik Hospital','Inje University')
to.combine[[258]] =c('Keimyung University, Dongsan Medical Center','Keimyung University')
to.combine[[259]] =c('University of Malaya Medical Centre','University of Malaya')
to.combine[[260]] =c('SRH University of Applied Health Sciences Gera','SRH University of Applied Health Sciences')
to.combine[[261]] =c('Split University Hospital','University of Split')
to.combine[[262]] =c('University Hospital of Tampere',"University of Tampere, Medical School",'University of Tampere')
to.combine[[263]] =c('Chung Shan Medical University Hospital','Chung Shan Medical University')
to.combine[[264]] =c('National Taiwan University Hospital','National Taiwan University')
to.combine[[265]] =c('Kaohsiung Medical University Chung-Ho Memorial Hospital','Kaohsiung Medical University')
to.combine[[266]] =c('Taipei Tzu Chi Hospital','Tzu Chi University')
to.combine[[267]] =c('First Affiliated Hospital of China Medical University','China Medical University Shenyang','First Hospital of China Medical University','Shengjing Hospital of China Medical University','Cancer Hospital of China Medical University','China Medical University Hospital Taichung','China Medical University Taichung','China Medical University')
to.combine[[268]] =c('National Cheng Kung University Hospital','National Cheng Kung University')
to.combine[[269]] =c('University of Auckland in New Zealand','Medical and Health Sciences, University of Auckland','University of Auckland')
to.combine[[270]] =c('Massey University, Auckland','Massey University')
to.combine[[271]] =c('University Al-Azhar','Al-Azhar University')
to.combine[[272]] =c('Zagazig University Hospitals','Zagazig University')
to.combine[[273]] =c('Mansoura University,','Mansoura University, Urology and Nephrology Center','Mansoura University')
to.combine[[274]] =c('Belgrade University','University of Belgrade')
to.combine[[275]] =c("Sydney Children's Hospitals Network (Randwick and Westmead)","Sydney Children's Hospitals Network")
to.combine[[276]] =c('Ramathibodi Hospital, Mahidol University','Mahidol University')
to.combine[[277]] =c('Aga Khan University Hospital','Aga Khan University')
to.combine[[278]] =c('Tartu University Hospital','University of Tartu')
to.combine[[279]] =c('College of Medicine and Health Sciences United Arab Emirates University','United Arab Emirates University')
to.combine[[280]] =c('University of Reykjavik','Reykjavik University')
to.combine[[281]] =c('University of the West Indies at Cave Hill','University of the West Indies')
# translations
to.combine[[282]] =c('Hacettepe Universitesi','Hacettepe University,','Hacettepe University')
to.combine[[283]] =c('Ankara Universitesi','Ankara University,','Ankara University')
to.combine[[284]] =c('Istanbul Universitesi','Istanbul University, Cerrahpasa','Istanbul University')
to.combine[[285]] =c('Trakya Universitesi','Trakya University,','Trakya University')
to.combine[[286]] =c('Gazi Universitesi','Gazi University','Gazi University')
to.combine[[287]] =c('Ege Universitesi','Ege University')
to.combine[[288]] =c("Universitetet i Oslo",'University of Oslo')
to.combine[[289]] =c('Sahlgrenska Universitetssjukhuset','Goteborgs Universitet','Goteborg University, Sahlgrenska Academy','University of Gothenburg') 
to.combine[[290]] =c('Lunds Universitet','Lund University')
to.combine[[291]] =c('Umea Universitet','Umea University,','Umea University')
to.combine[[292]] =c('Universidad CES','CES University')
to.combine[[293]] =c('Universidad El Bosque','El Bosque University')
to.combine[[294]] =c('Universidad de Costa Rica','Costa Rica University','University of Costa Rica')
to.combine[[295]] =c('Universite de Kinshasa','Kinshasa University')
to.combine[[296]] =c('Aalborg Universitet','Aalborg University')
to.combine[[297]] =c("Syddansk Universitet",'University of Southern Denmark')
to.combine[[298]] =c('Aarhus Universitet','Aarhus University')
to.combine[[299]] =c('Danmarks Tekniske Universitet','Technical University of Denmark')
to.combine[[300]] =c('Orebro Universitet','Örebro University')
to.combine[[301]] =c('Uppsala universitet','Uppsala University')
to.combine[[302]] =c('Universitetssjukhuset i Linkoping','Linkoping University','Linköping University')
to.combine[[303]] =c('Norges Teknisk-Naturvitenskapelige Universitet','Norwegian University of Science and Technology')                    
to.combine[[304]] =c('Universitetet i Bergen','University of Bergen')
to.combine[[305]] =c('Universitetet i Tromso','University of Tromso','University of Tromsø')
to.combine[[306]] =c('Universitetet i Stavanger','University of Stavanger')
to.combine[[307]] =c('Universiteti i Prishtines','University of Pristina')
to.combine[[308]] =c('IT-Universitetet i Kobenhavn','IT University of Copenhagen')
to.combine[[309]] =c('Universitetet for miljo- og biovitenskap','Norwegian University of Life Sciences')
to.combine[[310]] =c('Odense Universitetshospital','Odense University Hospital')
to.combine[[311]] =c('Arhus Universitetshospital','Aarhus University Hospital')
to.combine[[312]] =c('Vilniaus universitetas','Vilnius University')
to.combine[[313]] =c('Faculte de Medecine de Marseille Universite de la Mediterranee','Aix Marseille Universite','University of Aix-Marseille','Aix-Marseille University')
to.combine[[314]] =c("Universitat Bielefeld","Universitét Bielefeld","Bielefeld University")   
to.combine[[315]] =c("Universidade de Pernambuco, Faculdade de Ciencias Medicas","Universidade de Pernambuco")
to.combine[[316]] =c('Universidade do Estado de Santa Catarina','University of State of Santa Catarina')
to.combine[[317]] =c("Universidad de Cordoba", "Universidad de Cordoba, Facultad de Medicina", "University of Córdoba")
to.combine[[318]] =c("Centre Hospitalier de L'Universite de Montreal","Universite de Montreal", "Université de Montreál","Université de Montréal")
to.combine[[319]] =c("Universita Cattolica del Sacro Cuore, Rome, Facolta di Medicina e Chirurgia", "Universita Cattolica del Sacro Cuore, Rome")
to.combine[[320]] =c("Universitat de ValEncia", "Universitat de Valencia, Facultad de Medicina y Odontologia", "Universitat de Valencia")
to.combine[[321]] =c("Universidad de Valladolid, Facultad de Medicina", "Universidad de Valladolid")
to.combine[[322]] =c("Universidad de Valparaiso", "University of Valparaíso" )
to.combine[[323]] =c("Faculdade de Farmacia, Universidade de Lisboa","Faculdade de Medicina, Universidade de Lisboa","Faculdade de Motricidade Humana, Universidade de Lisboa","Faculdade de Medicina Veterinaria, Universidade de Lisboa","Universidade de Lisboa")
to.combine[[324]] =c("d Fédération de Médecine translationnelle de Strasbourg (FMTS)", "Fédération de Médecine Translationnelle de Strasbourg (FMTS)" )
to.combine[[325]] =c("Barts and The London Queen Mary's School of Medicine and Dentistry", "Queen Mary, University of London", "Queen Mary University of London")
to.combine[[326]] =c("Purdue University, Lafayette Weldon School of Biomedical Engineering", "Purdue University, Lafayette") # kept separate "Purdue University, Lafayette Calumet" )
to.combine[[327]] =c('Universitatsklinik Erlangen und Medizinische Fakultat', "Friedrich-Alexander-Universität Erlangen-Nürnberg" )
to.combine[[328]] =c("Rutgers New Jersey", "Rutgers Robert Wood Johnson","Rutgers Robert Wood Johnson Medical School at New Brunswick", "Rutgers, The State University of New Jersey")
to.combine[[329]] =c("UAB Comprehensive Cancer Center", "University of Alabama at Birmingham", "University of Alabama, Birmingham")
to.combine[[330]] =c("Samsung Medical Center, Sungkyunkwan University", "Sungkyunkwan University")
to.combine[[331]] =c("Royal College of Surgeons of Ireland Affiliated Hospital", "Royal College of Sur. in Ireland", "Royal College of Surgeons in Ireland")
to.combine[[332]] =c("Luxembourg Institute of Socio-Economic Research (LISER)", "Luxembourg Institute of Socio-Economic Research")
to.combine[[333]] =c("George Institute", "George Institute for Global Health")
to.combine[[334]] =c("St George's Hospital, London", "St George's University of London")
to.combine[[335]] =c("NYU Langone Medical Center", "NYU Lutheran System", "NYU Hospital for Joint Diseases","NYU College of Dentistry", "NYU", "NYU Steinhardt School of Culture, Education, and Human Development", "New York University")
to.combine[[336]] =c("VCU School of Dentistry", "VCU", "Virginia Commonwealth University")
to.combine[[337]] =c("^CASE$", "Case Western Reserve University")
to.combine[[338]] =c('Radboud University Nijmegen','Radboud University')
to.combine[[339]] =c("Universidade Federal do Ceará", "University of Ceara", "Federal University of Ceará")
to.combine[[340]] =c("Florey Institute of Neuroscience and Mental Health", 'University of Melbourne')
to.combine[[341]] =c("VU University Medical Center", 'VU University Amsterdam')
# switch back wrongly removed suffix
to.combine[[342]] =c('^Baylor$','Baylor College of Medicine') # 

# run the combines/changes
for (k in 1:length(to.combine)){
  this = to.combine[[k]]
  index = grep(paste(this[1:(length(this)-1)], collapse = '|', sep=''), papers$affiliation)
  papers$affiliation[index] = this[length(this)] # change to last name in vector
}

# fix for Temple Uni; code above can't pick up apostrophes
index = grep('Temple University', papers$affiliation)
papers$affiliation[index] = 'Temple University'
# another fix, not sure why this is not working above
index = grep('University of Washington', papers$affiliation)
papers$affiliation[index] = 'University of Washington'
# another fix, not sure why this is not working above, something to do with commas?
index = grep('University of Pittsburgh', papers$affiliation)
papers$affiliation[index] = 'University of Pittsburgh'
# fix those ending with a comma
papers$affiliation = gsub(',$', '', papers$affiliation)

# fix wrong countries
papers$country[ grep('Emory', papers$affiliation)] = 'United States' # Some Georgia!
papers$country[ grep('University College London', papers$affiliation)] = 'United Kingdom'
papers$country[ grep('University of Warwick', papers$affiliation)] = 'United Kingdom' # one USA
papers$country[ grep('Yale University', papers$affiliation)] = 'United States' # one USA
papers$country[ grep('Western Michigan University', papers$affiliation)] = 'United States' # one Canada
papers$country[ grep('Weill Cornell Medical College', papers$affiliation)] = 'United States' # some Qatar
papers$country[ grep('University of Valparaíso', papers$affiliation)] = 'Chile' # one USA
papers$country[ grep('University of Strathclyde', papers$affiliation)] = 'United Kingdom' # some France
papers$country[ grep('University of St Andrews', papers$affiliation)] = 'United Kingdom' # one Australia
papers$country[ grep('University of Queensland', papers$affiliation)] = 'Australia' # three UK
papers$country[ grep('University of Oxford', papers$affiliation)] = 'United Kingdom' # two Viet Nam
papers$country[ grep('University of Nottingham', papers$affiliation)] = 'United Kingdom' # two Malaysia
papers$country[ grep('University of North Carolina, Chapel Hill', papers$affiliation)] = 'United States' # three China
papers$country[ grep('University of Exeter', papers$affiliation)] = 'United Kingdom' # one Netherlands
papers$country[ grep('University of East Anglia', papers$affiliation)] = 'United Kingdom' # one USA
papers$country[ grep('University of Auckland', papers$affiliation)] = 'New Zealand' # one USA
papers$country[ grep('University of British Columbia', papers$affiliation)] = 'Canada' # one Colombia
papers$country[ grep('Université de Montréal', papers$affiliation)] = 'Canada' # one Colombia
papers$country[ grep('University of Alabama, Birmingham', papers$affiliation)] = 'United States' # one UK
papers$country[ grep("Federal University of Ceará", papers$affiliation)] = 'Brazil' # one USA
papers$country[ grep("Paracelsus Medical University", papers$affiliation)] = 'Germany' # one Australia
papers$country[ grep("Northeastern University China", papers$affiliation)] = 'China' # lots of USA
papers$country[ grep("Monash University", papers$affiliation)] = 'Australia' # lots of Malaysia
papers$country[ grep("Johns Hopkins University", papers$affiliation)] = 'United States' # one Singapore
papers$country[ grep("Kinshasa University", papers$affiliation)] = 'Democratic Republic of the Congo' # one Congo
papers$country[ grep("London School of Hygiene & Tropical Medicine", papers$affiliation)] = 'United Kingdom' # one Germany
papers$country[ grep("Institut Pasteur, Paris", papers$affiliation)] = 'France' # all sorts
papers$country[ grep("Griffith University", papers$affiliation)] = 'Australia' # one UAE
papers$country[ grep("Harvard University", papers$affiliation)] = 'United States' # one Botswana
papers$country[ grep("Dartmouth College", papers$affiliation)] = 'United States' # one Lebanon
papers$country[ grep("Chulalongkorn University", papers$affiliation)] = 'Thailand' # one USA

index = papers$country == 'Australia' & papers$affiliation == 'University of Newcastle' & is.na(papers$affiliation)==F
papers$affiliation[index] = 'University of Newcastle, Australia' # Be consistent with country suffix

# save
papers = subset(papers, select=c("doi","affiliation","country","year","Region","University",'weight'))
save(papers, pubmed.frame, date.searched, file='Papers.for.Shiny.RData') # 

# check: look for repeats of university names
all = as.character(unique(papers$affiliation))
unis = all[grep('University', all)]
# get word before/after 'University'
where.uni = str_locate(pattern='University', string=unis)
out = file('check.unis.txt', 'w')
for (k in 756:length(unis)){
  if(where.uni[k,1]==1){words = str_sub(string=unis[k], start=where.uni[k,2]+2, end=nchar(unis[k]))} # after
  if(where.uni[k,1]!=1){words = str_sub(string=unis[k], start=1, end=where.uni[k,1]-2)} # before
  # now search
  search = grep(words, all)
  if (length(search)>1){ # possible double
    cat(all[search], '\n', sep='\n', file=out)
  }
}
close(out)

# final checks
all = as.character(unique(papers$affiliation))
all = all[is.na(all)==F]
all[grep('University Hospital', all)]
all[grep('Universitet', all)] # translation
all[grep('Universidad', all)] # translation

# How does our list of universities compare with Leiden
leiden = read_excel('CWTS Leiden Ranking 2017.xlsx', sheet='Results')
leiden.places = unique(leiden$University)
leiden.places[leiden.places%in%papers$affiliation==F]

# Check for affiliations in more than two countries
tab = with(papers, table(country, affiliation))
r = colSums(tab>0)
r[r>1]
