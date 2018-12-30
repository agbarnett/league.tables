# data.management.R
# manage the affilation data to create consistent university naming
# December 2018
library(readxl)
library(stringr)

## get the papers data
load('Papers.RData') # from equator.data.R
papers.temp = papers
load('Papers2.RData') # from equator.data.R
papers = rbind(papers, papers.temp); rm(papers.temp) # combine two data sets
# make year
papers$year = as.numeric(substr(as.character(papers$date),1,4))
# convert to characters/numbers
papers$affid = as.numeric(as.character(papers$affid))
papers$country = as.character(papers$country)
papers$affiliation = as.character(papers$affiliation)
papers$doi = as.character(papers$doi)
papers$title = as.character(papers$title)
papers$journal = as.character(papers$journal)
# one edit
papers$country[papers$country=='Geneve'] = 'Switzerland'
# add region (had to edit some countries by hand) - also fixed towards end of code
region = read_excel('country.data.xls', skip=2)
# merge region with papers (include missing)
papers = merge(papers, region, by.x='country', by.y='Country', all.x=T)
papers$affiliation = as.character(papers$affiliation)
# fix some special characters
papers$affiliation = gsub('ï¿½', 'é', papers$affiliation)
papers$affiliation = gsub('&amp;', '&', papers$affiliation)
papers$affiliation = gsub('Hopital ', 'Hôpital ', papers$affiliation) # to be consistent and give better merge with Leiden

## big list of changes, done using combine function below, which also records ID numbers; change to last name in list
## two uncertain:
# (Universite de Rennes 1','University of Rennes') # badly reported, 1 or 2?
# Azienda Ospedaliero - Universitaria di Modena Policlinico
## start with fixes for merge with Leiden
to.combine = list()
to.combine = c(to.combine, list(c("St Mary's Hospital London", "St. Mary's Hospital, London"))) # 
to.combine = c(to.combine, list(c('All India Institute of Medical Sciences, New Delhi', 'All India Institute of Medical Science, New Delhi'))) # 
to.combine = c(to.combine, list(c('Ataturk University, Faculty of Medicine','Atatürk University')))
to.combine = c(to.combine, list(c('Universitatea Babes-Bolyai din Cluj-Napoca', 'Babeș-Bolyai University')))
to.combine = c(to.combine, list(c('Universita degli Studi di Brescia','Universita degli Studi di Brescia, Facolta di Medicina e Chirurgia','Brescia University')))
to.combine = c(to.combine, list(c('Beijing An Ding Hospital, Capital Medical University','Capital Medical University China', 'Capital Medical University')))
to.combine = c(to.combine, list(c('Universitat Oldenburg','Carl von Ossietzky University of Oldenburg')))
to.combine = c(to.combine, list(c('Charles University','Charles University, Prague')))
to.combine = c(to.combine, list(c('Universite Claude Bernard, Faculte de Medecine RTH Laennec','Universite Claude Bernard Lyon 1', 'Claude Bernard Lyon 1 University')))
to.combine = c(to.combine, list(c('Comenius University','Comenius University, Bratislava')))
to.combine = c(to.combine, list(c('Universite Concordia','Concordia University')))
to.combine = c(to.combine, list(c('Dokuz Eylul Universitesi','Dokuz Eylul Universitesi Tip Fakultesi', 'Dokuz Eylül University')))
to.combine = c(to.combine, list(c('Technische Universiteit Eindhoven','Eindhoven University of Technology')))
to.combine = c(to.combine, list(c('Erciyes Universitesi','Erciyes University')))
to.combine = c(to.combine, list(c('Ernst-Moritz-Arndt-Universitat Greifswald','Universitatsklinikum Greifswald der Ernst-Moritz-Arndt-Universitat Greifswald','University Medicine Greifswald' , 'Ernst-Moritz-Arndt University of Greifswald')))
to.combine = c(to.combine, list(c('Universidade Federal de Pernambuco','Federal University of Pernambuco - UFPE')))
to.combine = c(to.combine, list(c('Universidade Federal do Rio Grande do Norte','Federal University of Rio Grande do Norte - UFRN'))) # are some without north/south information
to.combine = c(to.combine, list(c('Universidade Federal do Rio Grande do Sul','Federal University of Rio Grande do Sul - UFRGS')))
to.combine = c(to.combine, list(c('Universidade Federal de Santa Catarina','Federal University of de Santa Catarina/UFSC','Federal University of Santa Catarina - UFSC')))
to.combine = c(to.combine, list(c('Universidade Federal de Sao Carlos','Federal University of São Carlos - UFSCar')))
to.combine = c(to.combine, list(c('Freie Universitat Berlin','Freie Universität Berlin')))
to.combine = c(to.combine, list(c('Friedrich Schiller Universitat Jena','Friedrich Schiller University Jena','Universitatsklinikum Jena und Medizinische Fakultat', 'Friedrich Schiller University in Jena')))
to.combine = c(to.combine, list(c('Universiteit Gent','Ghent University')))
to.combine = c(to.combine, list(c('Goethe-Universitat Frankfurt am Main','Klinikum und Fachbereich Medizin Johann Wolfgang Goethe-Universitat Frankfurt am Main', 'Goethe University Frankfurt')))
to.combine = c(to.combine, list(c('Gottfried Wilhelm Leibniz Universitat','Gottfried Wilhelm Leibniz Universität Hannover')))
to.combine = c(to.combine, list(c('Medizinische Hochschule Hannover \\(MHH\\)','Hannover Medical School')))
to.combine = c(to.combine, list(c('Universitat Heidelberg','Universitätsklinikum Heidelberg','Universitatsklinikum Heidelberg','Ruprecht-Karls-Universität Heidelberg','Universität Heidelberg'))) # is another one in Ohio
to.combine = c(to.combine, list(c('Heinrich Heine Universitat', 'Heinrich Heine University Düsseldorf')))
to.combine = c(to.combine, list(c('Heriot-Watt University, Edinburgh', 'Heriot-Watt University')))
to.combine = c(to.combine, list(c('Humboldt-Universitat zu Berlin', 'Humboldt-Universität zu Berlin')))
to.combine = c(to.combine, list(c('Indiana University-Purdue University Indianapolis', 'Indiana University - Purdue University Indianapolis')))
to.combine = c(to.combine, list(c('Indiana University','Indiana University, Bloomington')))
to.combine = c(to.combine, list(c('Islamic Azad University', 'Islamic Azad University Science & Research Tehran')))
to.combine = c(to.combine, list(c('Uniwersytet Jagiellonski w Krakowie', 'Jagiellonian University, Krakow')))
to.combine = c(to.combine, list(c('Universidad Jaume I', 'Jaume I University')))
to.combine = c(to.combine, list(c('Johannes Gutenberg Universitat Mainz', 'Johannes Gutenberg University Mainz')))
to.combine = c(to.combine, list(c('Julius-Maximilians-Universitat Wurzburg', 'Julius Maximilian University of Würzburg')))
to.combine = c(to.combine, list(c('Karolinska Institutet', 'Karolinska Institute')))
to.combine = c(to.combine, list(c('KU Leuven','KU Leuven– University Hospital Leuven','KU Leuven - University of Leuven Department of Rehabilitation Sciences', 'Katholieke Universiteit Leuven')))
to.combine = c(to.combine, list(c('Christian-Albrechts-Universitat zu Kiel', 'Kiel University')))
to.combine = c(to.combine, list(c('Kunming University of Science and Technology', 'Kunming University of Science & Technology')))
to.combine = c(to.combine, list(c('Universite Laval','Universite Laval, Faculte de medecine', 'Laval University')))
to.combine = c(to.combine, list(c('Universitat Leipzig','Universitatsklinikum Leipzig und Medizinische Fakultat', 'Leipzig University'))) 
to.combine = c(to.combine, list(c('London School of Hygiene and Tropical Medicine', 'London School of Hygiene & Tropical Medicine'))) 
to.combine = c(to.combine, list(c('Loyola University of Chicago', 'Loyola University Medical Center','Loyola University Stritch','Loyola University Chicago')))
to.combine = c(to.combine, list(c('University of Illinois, Chicago','University of Illinois at Chicago','University of Illinois at Urbana-Champaign','University of Illinois')))
to.combine = c(to.combine, list(c('Chicago Medical School','Rosalind Franklin University of Medicine and Science')))
to.combine = c(to.combine, list(c('Ludwig-Maximilians-Universitat Munchen','University of Ludwig-Maximillians', 'Ludwig-Maximilians-Universität München')))
to.combine = c(to.combine, list(c('Marmara Universitesi','Marmara Universitesi Tip Fakultesi', 'Marmara University')))
to.combine = c(to.combine, list(c('Martin-Universitat Halle-Wittenberg', 'Martin Luther University of Halle-Wittenberg')))
to.combine = c(to.combine, list(c('Metropolitan University \\(UAM\\)', 'Metropolitan Autonomous University')))
to.combine = c(to.combine, list(c('National Central University' , 'National Central University'))) 
to.combine = c(to.combine, list(c('National Chiao Tung University Taiwan', 'National Chiao Tung University'))) 
to.combine = c(to.combine, list(c('Universidad Nacional de Cordoba' , 'National University of Cordoba')))
to.combine = c(to.combine, list(c('National University of Ireland Galway', 'National University of Ireland, Galway')))
to.combine = c(to.combine, list(c('Newcastle University, United Kingdom','University of Newcastle upon Tyne, Faculty of Medicine','Newcastle University')))
to.combine = c(to.combine, list(c('Uniwersytet Mikołaja Kopernika w Toruniu','Nicholas Copernicus University of Torun')))
to.combine = c(to.combine, list(c('North Carolina State University', 'North Carolina State University Raleigh')))
to.combine = c(to.combine, list(c('North-West University', 'North West University')))
to.combine = c(to.combine, list(c('Northeastern University China', 'Northeastern University, China')))  
to.combine = c(to.combine, list(c('Northeastern University', 'Northeastern University, USA')))
to.combine = c(to.combine, list(c('Oregon Health and Science University', 'Oregon Health & Science University')))   
to.combine = c(to.combine, list(c('Otto von Guericke University of Magdeburg', 'Otto von Guericke University Magdeburg')))
to.combine = c(to.combine, list(c('University of Plymouth', 'Plymouth University')))
to.combine = c(to.combine, list(c('Ecole Polytechnique de Montreal', 'Polytechnique de Montréal')))
to.combine = c(to.combine, list(c('Universitat Pompeu Fabra','Universitat Popmpeu Fabra \\(UPF\\)', 'Pompeu Fabra University')))
to.combine = c(to.combine, list(c('Pontificia Universidad Catolica de Chile', 'Pontificia Universidad Católica de Chile')))
to.combine = c(to.combine, list(c('Postgraduate Institute of Medical Education and Research', 'Postgraduate Institute of Medical Education & Research')))
to.combine = c(to.combine, list(c('Prince of Songkla University', 'Prince Songkla University')))
to.combine = c(to.combine, list(c('Purdue University, Lafayette', 'Purdue University')))
to.combine = c(to.combine, list(c('Queensland University of Technology QUT','Queensland University of Technology')))
to.combine = c(to.combine, list(c('Universitat Rovira i Virgili', 'Rovira i Virgili University')))
to.combine = c(to.combine, list(c('University of Bochum', 'Ruhr-Universität Bochum')))
to.combine = c(to.combine, list(c('Universitatsklinikum des Saarlandes Medizinische Fakultat der Universitat des Saarlandes','Universitat des Saarlandes', 'Saarland University')))
to.combine = c(to.combine, list(c('Università degli Studi della Campania Luigi Vanvitelli', 'Second University of Naples')))
to.combine = c(to.combine, list(c('Selcuk Universitesi','Seléuk éniversitesi', 'Selçuk University')))
to.combine = c(to.combine, list(c('Semmelweis Egyetem','Semmelweis University, Faculty of Medicine', 'Semmelweis University of Budapest')))
to.combine = c(to.combine, list(c('Shiraz University of Medical Sciences', 'Shiraz University of Medical Science')))
to.combine = c(to.combine, list(c('University of Silesia in Katowice', 'University of Silesia')))
to.combine = c(to.combine, list(c('St. Louis University','St. Louis University School of Medicine', 'St Louis University')))  
to.combine = c(to.combine, list(c('Universidade Estadual de Maringa', 'State University of Maringá')))
to.combine = c(to.combine, list(c('Universidade do Estado do Rio de Janeiro', 'State University of Rio de Janeiro - UERJ')))
to.combine = c(to.combine, list(c('Universiteit Stellenbosch', 'Stellenbosch University')))
to.combine = c(to.combine, list(c('Stockholms universitet','Stressforskningsinstitutet, Stockholms universitet', 'Stockholm University')))
to.combine = c(to.combine, list(c('Sun Yat-Sen University','Sun Yat-Sen University Cancer Center', 'Sun Yat-sen University')))
to.combine = c(to.combine, list(c('Universidad Politecnica de Madrid', 'Technical University of Madrid')))
to.combine = c(to.combine, list(c('Universidad Autonoma de Madrid, Facultad de Medicina','Universidad Autonoma de Madrid')))
to.combine = c(to.combine, list(c('Technische Universitat Darmstadt', 'Technische Universität Darmstadt')))
to.combine = c(to.combine, list(c('TU Dortmund University', 'Technische Universität Dortmund')))
to.combine = c(to.combine, list(c('Technische Universitat Dresden', 'Technische Universität Dresden')))
to.combine = c(to.combine, list(c('Technische Universitat Kaiserslautern', 'Technische Universität Kaiserslautern')))
to.combine = c(to.combine, list(c('Technical University of Munich', 'Technische Universität München')))
to.combine = c(to.combine, list(c('Trinity College Dublin', 'Trinity College Dublin, The University of Dublin')))
to.combine = c(to.combine, list(c('Universite Grenoble Alpes','Grenoble Alps University', 'Univ Grenoble Alpes')))
to.combine = c(to.combine, list(c('UNESP-Universidade Estadual Paulista', 'Universidade Estadual Paulista')))
to.combine = c(to.combine, list(c('São Paulo Federal University \\(UNIFESP\\)', 'Universidade Federal de São Paulo')))
to.combine = c(to.combine, list(c('Universidade Federal de Vicosa', 'Universidade Federal de Viçosa')))
to.combine = c(to.combine, list(c('Federal University of Ceara','Universidade Federal do Ceara', 'Universidade Federal do Ceará')))
to.combine = c(to.combine, list(c('Universidade Federal do Parana', 'Universidade Federal do Paraná')))
to.combine = c(to.combine, list(c('Universidade Federal Fluminense' , 'Universidade Federal Fluminense - UFF')))
to.combine = c(to.combine, list(c('Universita Cattolica del Sacro Cuore','Universita Cattolica del Sacro Cuore, Rome','Universita Cattolica del Sacro Cuore, Rome, Facolta di Medicina e Chirurgia', 'Università Cattolica del Sacro Cuore')))
to.combine = c(to.combine, list(c('Universita degli Studi di Genova','Università degli Studi di Genova' , 'University of Genoa')))
to.combine = c(to.combine, list(c('Universita degli studi Magna Graecia di Catanzaro', 'Magna Græcia University')))
to.combine = c(to.combine, list(c('Universita Campus Bio-Medico di Roma', 'Campus Bio-Medico University')))
to.combine = c(to.combine, list(c('Universita Bocconi','Bocconi University')))
to.combine = c(to.combine, list(c("Universita degli Studi dell'Insubria", 'University of Insubria')))
to.combine = c(to.combine, list(c('Universita degli Studi del Piemonte Orientale Amedeo Avogadro, Novara', 'University of Eastern Piedmont')))
to.combine = c(to.combine, list(c('Hunter Medical Research Institute, Australia', 'University of Newcastle, Australia')))
to.combine = c(to.combine, list(c('Universitat Hamburg', 'Universität Hamburg')))
to.combine = c(to.combine, list(c('Universita Politecnica delle Marche','Université Politecnica delle Marche' , 'Università Politecnica delle Marche')))
to.combine = c(to.combine, list(c('Universitat Politecnica de Catalunya' , 'Universitat Politècnica de Catalunya')))
to.combine = c(to.combine, list(c('Universitat Regensburg' , 'Universität Regensburg')))
to.combine = c(to.combine, list(c("Universite d' Auvergne Clermont-FD 1","Universite d'Auvergne, Faculte de Medecine Clermont-Ferrand", 'Université Clermont-Auvergne')))
to.combine = c(to.combine, list(c('Universite de Franche-Comte' , 'Université de Franche-Comté')))
to.combine = c(to.combine, list(c('Universite de Nantes' , 'Université de Nantes')))
to.combine = c(to.combine, list(c('Universite de Sherbrooke' , 'Université de Sherbrooke')))
to.combine = c(to.combine, list(c('Universite Paul Sabatier Toulouse III', 'Université Paul Sabatier')))
   to.combine = c(to.combine, list(c('University at Buffalo, State University of New York', 'University at Buffalo, The State University of New York')))
   to.combine = c(to.combine, list(c('Universite Francois-Rabelais Tours','Universite Francois Rabelais Faculte de Medicine', 'University François Rabelais of Tours')))
   to.combine = c(to.combine, list(c('Universidade da Coruña','Complejo Hospitalario Universitario A Coruña','Complejo Hospitalario Universitario de A Coruña' , 'University of A Coruña')))
   to.combine = c(to.combine, list(c('University at Albany State University of New York', 'University of Albany, The State University of New York')))
   to.combine = c(to.combine, list(c('Universiteit Antwerpen','Universitair Ziekenhuis Antwerpen', 'University of Antwerp')))
   to.combine = c(to.combine, list(c('Universidade de Aveiro', 'University of Aveiro')))
   to.combine = c(to.combine, list(c('Universidad de Alcala' , 'University of Alcalá')))
   to.combine = c(to.combine, list(c('Universita degli Studi di Bari' , 'University of Bari Aldo Moro')))
   to.combine = c(to.combine, list(c('Universitat Basel','Universitatsspital Basel','Allgemeinchirurgische Klinik, Universitatsspital Basel' , 'University of Basel')))
   to.combine = c(to.combine, list(c('Universitat Bern','UniversitatsSpital Bern','University of Bern, Institute of Pathology' , 'University of Bern')))
   to.combine = c(to.combine, list(c('University of Arkansas for Medical Sciences' , 'University of Arkansas for Medical Sciences, Little Rock')))
   to.combine = c(to.combine, list(c('University of Alabama School of Medicine','University of Alabama', 'University of Alabama, Tuscaloosa')))
   to.combine = c(to.combine, list(c('Universitat de Barcelona' , 'University of Barcelona')))
   to.combine = c(to.combine, list(c('Alma Mater Studiorum Universita di Bologna' , 'University of Bologna')))
   to.combine = c(to.combine, list(c('Universitat Bonn' , 'University of Bonn')))
   to.combine = c(to.combine, list(c('Universite de Bordeaux' , 'University of Bordeaux')))
   to.combine = c(to.combine, list(c('Universidade de Brasilia' , 'University of Brasília - UnB')))
   to.combine = c(to.combine, list(c('Azienda Ospedaliero Universitaria di Cagliari','Azienda Ospedaliero Universitaria di Cagliari, Presidio Policlinico di Monserrato','Universita degli Studi di Cagliari' , 'University of Cagliari')))
   to.combine = c(to.combine, list(c('Universita della Calabria' , 'University of Calabria')))
   to.combine = c(to.combine, list(c('Campinas University','Universidade Estadual de Campinas' ,'University of Campinas')))
   to.combine = c(to.combine, list(c('Universidad de Cantabria' , 'University of Cantabria')))
   to.combine = c(to.combine, list(c('Carleton University' , 'University of Carleton')))
   to.combine = c(to.combine, list(c('Universidad de Castilla-La Mancha' , 'University of Castilla-La Mancha')))
   to.combine = c(to.combine, list(c('Universita degli Studi di Catania'  , 'University of Catania')))
   to.combine = c(to.combine, list(c('Facultad de Medicina de la Universidad de Chile','Universidad de Chile' ,'University of Chile')))
   to.combine = c(to.combine, list(c('Universitat zu Koln' , 'University of Cologne')))
   to.combine = c(to.combine, list(c('University of Concepcion' , 'University of Concepción')))
   to.combine = c(to.combine, list(c('CHU AP-HM Hôpital de la Conception \\(Marseille\\)', 'Hôpital la Conception, Marseille')))
   to.combine = c(to.combine, list(c('Universidad de Cordoba, Facultad de Medicina','Universidad de Cordoba' , 'University of Cordoba')))
   to.combine = c(to.combine, list(c('Debreceni Egyetem','Debreceni Egyetem Nepegeszsegugyi Kar' , 'University of Debrecen')))
   to.combine = c(to.combine, list(c('Universitat Duisburg-Essen', 'University of Duisburg-Essen')))
   to.combine = c(to.combine, list(c('Universita degli Studi di Firenze', 'University of Florence')))
   to.combine = c(to.combine, list(c('Gdanski Uniwersytet Medyczny', 'Gdańsk Medical University')))
   to.combine = c(to.combine, list(c('Hopitaux universitaires de Geneve','Universite de Geneve','Universite de Geneve Faculte de Medecine' , 'University of Geneva')))
   to.combine = c(to.combine, list(c('Universitat de Girona' , 'University of Girona')))
   to.combine = c(to.combine, list(c('Universitat Gottingen','Universitatsmedizin Gottingen','University Hospital of Géttingen' , 'University of Göttingen')))
   to.combine = c(to.combine, list(c('Karl-Franzens-Universitat Graz','Medizinische Universitat Graz', 'University of Graz')))
   to.combine = c(to.combine, list(c('Universitat Hohenheim','Universitét Hohenheim', 'University of Hohenheim')))
   to.combine = c(to.combine, list(c('Medizinische Universitat Innsbruck' , 'Medical University of Innsbruck'))) # separate to Uni of Innsbruck
   to.combine = c(to.combine, list(c('Universitat Konstanz', 'University of Konstanz')))
 to.combine = c(to.combine, list(c("Universita degli Studi dell'Aquila", "University of L'Aquila")))
 to.combine = c(to.combine, list(c('Universidad de Malaga', 'University of Malaga')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Messina','Universita degli Studi di Messina, Facolta di Medicina e Chirurgia', 'University of Messina')))
 to.combine = c(to.combine, list(c('Orthopaedics Department of Minho University','Universidade do Minho','Universidade do Minho, Escola de Ciencias da Saude' , 'University of Minho')))
 to.combine = c(to.combine, list(c('Universite de Montpellier' , 'University of Montpellier')))
 to.combine = c(to.combine, list(c('Universidad de Murcia','Universidad de Murcia, Facultad de Medicina' , 'University of Murcia')))
 to.combine = c(to.combine, list(c('Clinica Universitaria de Navarra','Universidad de Navarra' , 'University of Navarra')))
 to.combine = c(to.combine, list(c('Universite de Liege','Universite de Liege','Centre Hospitalier Universitaire de Liege' , 'University of Liège')))
 to.combine = c(to.combine, list(c('Universitat Lausanne Schweiz' , 'University of Lausanne')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Milano - Bicocca', 'University of Milano-Bicocca')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Milano' , 'University of Milan')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Modena e Reggio Emilia'  , 'University of Modena and Reggio Emilia')))
 to.combine = c(to.combine, list(c('Universitatsklinikum Munster','Westfalische Wilhelms-Universitat Munster' , 'University of Münster')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Napoli Federico II' , 'University of Naples Federico II')))
 to.combine = c(to.combine, list(c('University of Nevada School of Medicine' , 'University of Nevada, Reno')))
 to.combine = c(to.combine, list(c('Universite Nice Sophia Antipolis' , 'University of Nice Sophia Antipolis')))
 to.combine = c(to.combine, list(c('The University of North Carolina at Charlotte' , 'University of North Carolina, Charlotte')))
 to.combine = c(to.combine, list(c('The University of North Carolina at Chapel Hill','University of North Carolina School of Medicine','University of North Carolina School of Dentistry','University of North Carolina Project-China' , 'University of North Carolina, Chapel Hill')))
 to.combine = c(to.combine, list(c('University of North Texas Health Science Center' , 'University of North Texas')))
 to.combine = c(to.combine, list(c('University of Notre Dame Australia' , 'University of Notre Dame')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Padova','Universita degli Studi di Padova, Facolta di Medicina e Chirurgia' , 'University of Padova')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Palermo', 'University of Palermo')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Parma','Azienda Ospedaliero-Universitaria of Parma','Azienda Ospedaliero - Universitaria di Parma','Universita degli Studi di Parma, Facolta di Medicina e Chirurgia', 'University of Parma')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Pavia', 'University of Pavia')))
 to.combine = c(to.combine, list(c('Universita degli Studi di Perugia', 'University of Perugia')))
 to.combine = c(to.combine, list(c('Universite de Poitiers','Centre Hospitalier Universitaire de Poitiers', 'University of Poitiers')))
 to.combine = c(to.combine, list(c('Universitat Potsdam', 'University of Potsdam')))
 to.combine = c(to.combine, list(c('Universiteit van Pretoria', 'University of Pretoria')))
 to.combine = c(to.combine, list(c('Universite du Quebec a Montreal', 'University of Quebec at Montreal')))
 to.combine = c(to.combine, list(c('Universite de Rennes 1','Universite Rennes I Faculte de Medecine', 'University of Rennes 1')))
 to.combine = c(to.combine, list(c('Universitat Rostock Uniklinikum und Medizinische Fakultat','Universitat Rostock','Universitätsmedizin Rostock' , 'University of Rostock')))
    to.combine = c(to.combine, list(c('Universidad de Salamanca','Hospital Universitario de Salamanca', 'University of Salamanca')))
    to.combine = c(to.combine, list(c('Universita di Salerno', 'University of Salerno')))
    to.combine = c(to.combine, list(c('Universidad de Santiago de Compostela','Universidad de Santiago de Compostela, Facultad de Medicina', 'University of Santiago de Compostela')))
    to.combine = c(to.combine, list(c('Universita degli Studi di Sassari','University Hospital of Sassari' , 'University of Sassari')))
    to.combine = c(to.combine, list(c('Universite de Strasbourg', 'University of Strasbourg')))
    to.combine = c(to.combine, list(c('Universitat Stuttgart' , 'University of Stuttgart')))
    to.combine = c(to.combine, list(c('University of Technology Sydney', 'University of Technology, Sydney')))
    to.combine = c(to.combine, list(c('Universitat de les Illes Balears' , 'University of the Balearic Islands')))
    to.combine = c(to.combine, list(c('Universidade do Porto' , 'University of Porto')))
    to.combine = c(to.combine, list(c('Tokushima University','Tokushima University Hospital', 'University of Tokushima')))
    to.combine = c(to.combine, list(c('Universita degli Studi di Roma Tor Vergata', 'University of Tor Vergata')))
    to.combine = c(to.combine, list(c('Universita degli Studi di Trento', 'University of Trento')))
    to.combine = c(to.combine, list(c('Universita degli Studi di Trieste', 'University of Trieste')))
    to.combine = c(to.combine, list(c('Universitat Tubingen','Universitatsklinikum Tubingen Medizinische Fakultat' , 'University of Tübingen')))
    to.combine = c(to.combine, list(c('Turun yliopisto','Turun Yliopistollinen Keskussairaala' , 'University of Turku')))
    to.combine = c(to.combine, list(c('Universita degli Studi di Torino', 'University of Turin')))
    to.combine = c(to.combine, list(c('Universitatsklinikum Ulm','Universitat Ulm' , 'University of Ulm')))
    to.combine = c(to.combine, list(c('Universitat de Valencia, Facultad de Medicina y Odontologia','Universitat de Valencia', 'University of Valencia')))
    to.combine = c(to.combine, list(c('Universidad de Valladolid','Hospital Universitario de Valladolid','Universidad de Valladolid, Facultad de Medicina' , 'University of Valladolid')))
    to.combine = c(to.combine, list(c('Universita degli Studi di Verona','Universita degli Studi di Verona, Facolta di Medicina e Chirurgia' , 'University of Verona')))
    to.combine = c(to.combine, list(c('Universitat Wien', 'University of Vienna')))
    to.combine = c(to.combine, list(c('Medizinische Universitat Wien','Universitatsklinik fur Neurologie, Medical University of Vienna','Medical University of Vienna Institute of Cancer Research','Medizinische University of Vienna' , 'Medical University of Vienna')))
    to.combine = c(to.combine, list(c('Technische University of Vienna', 'Vienna University of Technology')))
    to.combine = c(to.combine, list(c('Universidad de Vigo', 'University of Vigo')))
    to.combine = c(to.combine, list(c('Western Sydney University', 'University of Western Sydney')))
    to.combine = c(to.combine, list(c('Universidad de Zaragoza','Universidad de Zaragoza, Facultad de Medicina','Universidad de Zaragoza, Facultad de Veterinaria', 'University of Zaragoza')))
    to.combine = c(to.combine, list(c('Universitat Zurich','University Hospital Zurich Neurologische Klinik','UniversitatsSpital Zurich','University of Zurich Brain Research Institute', 'University of Zurich')))
    to.combine = c(to.combine, list(c('Uppsala Universitet', 'Uppsala University')))
    to.combine = c(to.combine, list(c('Vilniaus universitetas', 'Vilnius University')))
  to.combine = c(to.combine, list(c('Vrije Universiteit Amsterdam', 'VU University Amsterdam')))
  to.combine = c(to.combine, list(c('Wageningen University and Research Centre', 'Wageningen University & Research')))
  to.combine = c(to.combine, list(c('Universite Paris Descartes', 'University of Paris V - Paris Descartes')))
  to.combine = c(to.combine, list(c('Universite Paris-Sud XI', 'University of Paris XI - Paris-Sud')))
  to.combine = c(to.combine, list(c('Universite Pierre et Marie Curie', 'University of Paris VI - Pierre and Marie Curie')))
  to.combine = c(to.combine, list(c('Paris Diderot University','Universite Paris 7- Denis Diderot', 'University of Paris VII - Paris Diderot')))
  to.combine = c(to.combine, list(c('Universite Paris 12 Val de Marne', 'University of Paris XII - Paris-Est Créteil Val de Marne')))
  to.combine = c(to.combine, list(c('University of Texas at Dallas', 'University of Texas, Dallas')))
  to.combine = c(to.combine, list(c('University of Texas Health Science Center at San Antonio' , 'University of Texas Health Science Center, San Antonio')))
  to.combine = c(to.combine, list(c('University of Texas at San Antonio' , 'University of Texas, San Antonio')))
  to.combine = c(to.combine, list(c('University of Texas at Arlington', 'University of Texas, Arlington')))
  to.combine = c(to.combine, list(c('UT Medical Branch at Galveston', 'University of Texas Medical Branch at Galveston')))
  to.combine = c(to.combine, list(c('University of Texas at Dallas', 'University of Texas, Dallas')))
  to.combine = c(to.combine, list(c('University of Texas Health Science Center at Houston','University of Texas School of Nursing at Houston', 'University of Texas Health Science Center, Houston')))
  to.combine = c(to.combine, list(c('University of Colorado at Boulder','University of Colorado-Boulder School of Law', 'University of Colorado, Boulder')))
  to.combine = c(to.combine, list(c('University of Colorado at Denver','University of Colorado at Denver Anschutz Medical Campus', 'University of Colorado, Denver')))
  to.combine = c(to.combine, list(c('University of Nebraska Medical Center, College of Dentistry', 'University of Nebraska Medical Center')))
  to.combine = c(to.combine, list(c('University of Nebraska - Lincoln','University of Nebraska, Lincoln')))
  to.combine = c(to.combine, list(c('University of Missouri-St. Louis','University of Missouri, St. Louis')))
  to.combine = c(to.combine, list(c('University of Missouri-Columbia','University of Missouri, Columbia')))
  to.combine = c(to.combine, list(c('University of Missouri-Kansas City','University of Missouri, Kansas City')))
  to.combine = c(to.combine, list(c('Warwick Medical School','University of Warwick Medical School', 'University of Warwick')))
  to.combine = c(to.combine, list(c('Berlin Institute of Health','Charite - Universitatsmedizin Berlin')))
  to.combine = c(to.combine, list(c('York Health Economics Consortium', 'University of York')))
  to.combine = c(to.combine, list(c('Beijing Tsinghua Changgeng Hospital', 'Tsinghua University')))
  to.combine = c(to.combine, list(c('GlaxoSmithKline, USA','c GSK','GSK','GSK Vaccines','GSK Vaccines Institute for Global Health','GSK Nigeria','Present address: GSK', 'GlaxoSmithKline')))
  to.combine = c(to.combine, list(c('Mayo', 'Mayo Clinic')))
  to.combine = c(to.combine, list(c('GlaxoSmithKline GmbH & Co. KG', 'GlaxoSmithKline plc.','GlaxoSmithKline Pharmaceuticals SA','GlaxoSmithKline')))
  # some changes made for Times Higher Ed:
  to.combine = c(to.combine, list(c('Technische Universitét Ménchen','Technische Universität München', 'Technical University of Munich')))
  to.combine = c(to.combine, list(c('Hong Kong University-Shenzhen Hospital','University of Hong Kong Li Ka Shing', 'The University of Hong Kong Li Ka Shing Faculty of Medicine','University of Hong Kong')))
  to.combine = c(to.combine, list(c('University of New South Wales \\(UNSW\\) Australia','University of New South Wales, Rural Clinical School', 'University of New South Wales')))
  to.combine = c(to.combine, list(c('Dartmouth-Hitchcock Medical Center','Dartmouth Institute for Health Policy and Clinical Practice','Geisel School of Medicine at Dartmouth','Tuck School of Business at Dartmouth', 'Dartmouth College')))
  to.combine = c(to.combine, list(c('Universitat Mannheim','Universitatsklinikum Mannheim', 'University of Mannheim')))
  to.combine = c(to.combine, list(c('Rheinisch-Westfalische Technische Hochschule Aachen','Medizinische Fakultat und Universitats Klinikum Aachen', 'RWTH Aachen University')))
  to.combine = c(to.combine, list(c('Universita di Pisa', 'University of Pisa')))
  to.combine = c(to.combine, list(c('Technische Universitat Dresden', 'Technische Universität Dresden'))) 
  to.combine = c(to.combine, list(c('Universite Catholique de Louvain', 'Université Catholique de Louvain'))) 
  to.combine = c(to.combine, list(c("Scuola Superiore Sant'Anna di Studi Universitari e di Perfezionamento", "Scuola Superiore Sant'Anna")))
  to.combine = c(to.combine, list(c('Universitatsklinikum Wurzburg', 'Julius Maximilian University of Würzburg')))
  to.combine = c(to.combine, list(c('Guangdong College of Pharmacy','Guangdong Pharmaceutical University')))
  to.combine = c(to.combine, list(c("Centre Hospitalier Universitaire de Saint Etienne", "Universite Jean Monnet - Saint Etienne Faculte de Medecine Jacques Lisfranc", "Universite Jean Monnet Saint Etienne")))
  to.combine = c(to.combine, list(c("d Fédération de Médecine translationnelle de Strasbourg (FMTS)", "Fédération de Médecine Translationnelle de Strasbourg (FMTS)")))
  to.combine = c(to.combine, list(c('Pasteur Institute', "Institut Pasteur, Paris")))
  to.combine = c(to.combine, list(c("Universidad San Sebastién","Universidad San Sebastian", "Universidad San Sebastiá N","Universidad San Sebastian")))
  to.combine = c(to.combine, list(c('Université Paris Est (UPEC)','Universite Paris-Est')))
  to.combine = c(to.combine, list(c("ICPS Institut CardioVasculaire Paris-Sud", "Faculte de Medecine Paris-Sud", "University of Paris XI - Paris-Sud")))
  to.combine = c(to.combine, list(c('Fire Brigade of Paris','Brigade de Sapeurs Pompiers de Paris (BSPP)')))
  to.combine = c(to.combine, list(c('Union South-East Asia Office','International Union Against Tuberculosis and Lung Disease (The Union)','International Union Against Tuberculosis and Lung Disease')))
  to.combine = c(to.combine, list(c("Instituto de Investigación Sanitaria de Navarra (IdiSNA)", "Navarra's Health Research Institute (IDISNA)", "Navarra Institute for Health Research (IdiSNA)")))
  to.combine = c(to.combine, list(c('Centre Hospitalier Universitaire de Clermont-Ferrant','Centre Hospitalier Universitaire de Clermont-Ferrand')))
  to.combine = c(to.combine, list(c('Hopital Haut-Leveque C.H.U de Bordeaux','CHU Hopitaux de Bordeaux')))
  to.combine = c(to.combine, list(c("Centre Hospitalier Universitaire de Nice, Hopital l'Archet",'Centre Hospitalier Universitaire de Nice')))
  to.combine = c(to.combine, list(c("Fonds de la Recherche Scientifique-FNRS",'Fonds de la Recherche Scientifique - FNRS')))
  to.combine = c(to.combine, list(c("Hotel Dieu CHU de Nantes","Hôpital de Nantes")))
  to.combine = c(to.combine, list(c("Société française d'arthroscopie junior (SFAJ) sous l’égide de la SFA","Société française d'arthroscopie Junior (SFAJ)")))
  to.combine = c(to.combine, list(c('Universite de Reims Champagne-Ardenne UFR de Medicine','Universit ï¿½ de Reims Champagne-Ardenne','Universite de Reims Champagne-Ardenne')))
  to.combine = c(to.combine, list(c('Universitätsmedizin Greifswald','University Medicine Greifswald')))
  to.combine = c(to.combine, list(c('Osaka University Faculty of Medicine','Osaka University')))
  to.combine = c(to.combine, list(c('Dresden University Faculty of Medicine and University Hospital Carl Gustav Carus','Dresden University')))
  to.combine = c(to.combine, list(c('Umea University, Faculty of Medicine','Umea University','Umeå University')))
  to.combine = c(to.combine, list(c('Ruhr-Universitat Bochum','University of Bochum')))
  to.combine = c(to.combine, list(c('German Center for Diabetes Research','German Center for Diabetes Research (DZD)')))
  to.combine = c(to.combine, list(c('Bayer Pharma AG','Bayer AG')))
  to.combine = c(to.combine, list(c('Universitatsklinikum Schleswig-Holstein Campus Lubeck', 'Universitatsklinikum Schleswig-Holstein Campus Kiel', 'Universitatsklinikum Schleswig-Holstein')))
  to.combine = c(to.combine, list(c('University of Cambridge, Institute of Public Health','University of Cambridge, School of Clinical Medicine','University of Cambridge')))
  to.combine = c(to.combine, list(c("School of Medicine, University of Auckland", "University of Auckland")))
  to.combine = c(to.combine, list(c("Hebrew University-Hadassah Medical School", "Hebrew University")))
  to.combine = c(to.combine, list(c("Yale", "Yale School of Nursing","Yale Child Study Center","Yale University School of Medicine","Yale Center for Clinical Investigation","Yale University")))
  to.combine = c(to.combine, list(c("Johns Hopkins", "Johns Hopkins Singapore","The Johns Hopkins School of Medicine","Johns Hopkins Hospital","Johns Hopkins University School of Nursing", "Johns Hopkins Children's Center","Johns Hopkins Bloomberg School of Public Health","Johns Hopkins Medicine", "John Hopkins University-MCC", "Johns Hopkins Bloomberg", "Wilmer Eye Institute at Johns Hopkins", "Johns Hopkins Medical Institutions", "Johns Hopkins Clinical Trials Unit","Johns Hopkins University")))
  to.combine = c(to.combine, list(c("Harvard" , "Harvard Stem Cell Institute","Brigham and Women's Hospital and Harvard Medical School", "Harvard Chan School of Public Health","Harvard Medical School","Massachusetts General Hospital and Harvard Medical School", "Harvard School of Public Health","Harvard School of Dental Medicine", "Dana-Farber Cancer Institute and Harvard Medical School", "Dana-Farber/Harvard Cancer Center", "Harvard Chan", "Harvard University")))
  to.combine = c(to.combine, list(c("David Geffen School of Medicine at UCLA", "UCLA Fielding", "UCLA School of Dentistry", "UCLA Health System", "University of California, Los Angeles")))
  to.combine = c(to.combine, list(c("Rutgers New Jersey","Rutgers School of Dental Medicine", "Rutgers Biomedical and Health Sciences", "Rutgers New Jersey Medical School Neurological Institute of New Jersey", "Rutgers New Jersey Medical School","Rutgers University-Newark Campus", "Rutgers, The State University of New Jersey")))
  to.combine = c(to.combine, list(c("Touro University - California", "Touro University")))
  to.combine = c(to.combine, list(c("Nagoya City University Graduate School of Medical Sciences" , 'Nagoya City University')))
  to.combine = c(to.combine, list(c("Graduate School of Agricultural and Life Sciences The University of Tokyo", 'University of Tokyo Hospital', 'University of Tokyo')))
  to.combine = c(to.combine, list(c("Kumamoto University", "Kumamoto University")))
  to.combine = c(to.combine, list(c("Panepistimio Thesalias", "University of Thessaly, School of Health Sciences" , 'University of Thessaly')))
  to.combine = c(to.combine, list(c("National and Kapodistrian University of Athens, School of Health Sciences", 'National and Kapodistrian University of Athens')))
  to.combine = c(to.combine, list(c("Ribeirão Preto School of Dentistry/ São Paulo University", 'São Paulo University', "Universidade de Sao Paulo - USP", "University of Séo Paulo (Universidade de Séo Paulo - USP)","University of Séo Paulo (FMRP-USP)","USP-Universidade de Séo Paulo","University of São Paulo")))
to.combine = c(to.combine, list(c("Santa Casa School of Medical Sciences", "Santa Casa School of Medicine", "Santa Casa Medical Sciences School")))
to.combine = c(to.combine, list(c("IMED Faculdade Meridional", "School of Dentistry - Faculdade Meridional IMED", "IMED")))
to.combine = c(to.combine, list(c("Lund University, School of Economics and Management", "Lund University")))
to.combine = c(to.combine, list(c("Affiliated DrumTower Hospital of Nanjing University Medical School", "Nanjing University")))
to.combine = c(to.combine, list(c("Central South University China School of Basic Medical Sciences","Central South University")))
to.combine = c(to.combine, list(c("Nursing School of Kunming Medical University", "Kunming Medical University")))
to.combine = c(to.combine, list(c("Binzhou Medical University School of Nursing", "Binzhou Medical University")))
to.combine = c(to.combine, list(c("Muğla Sıtkı Koçman University School of Health Department of Health Care Management", "Muğla Sıtkı Koçman University")))
to.combine = c(to.combine, list(c("School of Medical Sciences - Universiti Sains Malaysia", 'Universiti Sains Malaysia')))
to.combine = c(to.combine, list(c("University College Cork Dental School and Hospital", 'University College Cork'))) 
to.combine = c(to.combine, list(c("McMaster University, DeGroote School of Business", 'McMaster University Medical Centre', "McMaster University")))
to.combine = c(to.combine, list(c("Indiana University", 'Indiana University, Bloomington')))
to.combine = c(to.combine, list(c("University of Pennsylvania, School of Veterinary Medicine" , "University of Pennsylvania, Wharton School", 'University of Pennsylvania, Annenberg School for Communications','University of Pennsylvania, Health System','University of Pennsylvania, School of Dental Medicine','University of Pennsylvania')))
to.combine = c(to.combine, list(c("Lewis Katz School of Medicine at Temple University", "Temple University’s School of Social Work", "Temple University, Kornberg School of Dentistry", "Temple University’s Fox School of Business", 'Temple University')))
to.combine = c(to.combine, list(c('Texas A and M University','Texas A and M Health Science Center','Texas A and M AgriLife Research and Extension Center','Texas A&M University')))
to.combine = c(to.combine, list(c('University of Texas M. D. Anderson Cancer Center', "University of Texas MD Anderson Cancer Center")))
to.combine = c(to.combine, list(c('UT Southwestern', 'UT Southwestern Medical Center')))
to.combine = c(to.combine, list(c('Texas Tech University Health Sciences Center at El Paso','Texas Tech University Health Sciences Center at Lubbock','Texas Tech University at Lubbock','Texas Tech University Health Science Center','Texas Tech University Health Sciences Center-Permian Basin in Odessa','Texas Tech University')))
to.combine = c(to.combine, list(c("University of Washington School of Public Health and Community Medicine", "University of Washington, Medicine", "University of Washington Medical Center", 'University of Washington School of Medicine', "University of Washington, Seattle", 'University of Washington'))) # use version without Seattle to match Leiden
to.combine = c(to.combine, list(c("George Washington University School of Medicine and Health Sciences", 'George Washington University')))
to.combine = c(to.combine, list(c("Cooper Medical School of Rowan University",'Rowan University')))
to.combine = c(to.combine, list(c("West Virginia University School of Medicine Morgantown", 'West Virginia University Robert C. Byrd Health Sciences Center', "West Virginia University")))
to.combine = c(to.combine, list(c("Edinburgh Medical School, Centre for Reproductive Biology", "Edinburgh Medical School, MRC Centre for Inflammation Research", "Edinburgh Medical School")))
to.combine = c(to.combine, list(c("University of Cambridge, School of Clinical Medicine","University of Cambridge")))
to.combine = c(to.combine, list(c('Exercise Physiology La Trobe Rural Health School', 'La Trobe University')))
to.combine = c(to.combine, list(c("University of Sheffield, School of Medicine and Biomedical Sciences" , "University of Sheffield")))
to.combine = c(to.combine, list(c("University of Pittsburgh Graduate", 'University of Pittsburgh Medical Center','University of Pittsburgh Medical Center, Magee-Womens Hospital',"University of Pittsburgh Medical Center, Children's Hospital of Pittsburgh","University of Pittsburgh")))
to.combine = c(to.combine, list(c("Indiana University School of Medicine Indianapolis", 'Indiana University School of Dentistry', 'Indiana University School of Nursing Indianapolis','Indiana University Center for Aging Research', 'Indiana University Northwest', "Indiana University")))
to.combine = c(to.combine, list(c("Tulane University School of Public Health and Tropical Medicine", "Tulane University")))
to.combine = c(to.combine, list(c('University of Wisconsin School of Medicine and Public Health','University of Wisconsin Madison, School of Veterinary Medicine', 'University of Wisconsin Madison','University of Wisconsin, Madison'))) # "University of Wisconsin Hospital and Clinics" and "Medical College of Wisconsin" are separate
to.combine = c(to.combine, list(c('University of Wisconsin Milwaukee','University of Wisconsin, Milwaukee')))
to.combine = c(to.combine, list(c("Faculty of Medicine, Ramathibodi Hospital, Mahidol University", "Mahidol University")))
to.combine = c(to.combine, list(c("Malmo University Faculty of Odontology", 'Malmo University Hospital', 'University of Malmé','University of Malmé',"Malmo University")))
to.combine = c(to.combine, list(c("Dresden University Faculty of Medicine and University Hospital Carl Gustav Carus", "Dresden University")))
to.combine = c(to.combine, list(c("King Chulalongkorn Memorial Hospital, Faculty of Medicine Chulalongkorn University", "Chulalongkorn University")))
to.combine = c(to.combine, list(c("University of Lisbon Faculty of Medicine, Institute of Molecular Medicine", 'University of Lisbon')))
to.combine = c(to.combine, list(c("UCL Eastman Dental Institute", "UCL Institute of Child Health", "UCL School of Pharmacy", "UCL Institute of Education", "UCL Institute of Ophthalmology", "UCL Institute of Cognitive Neuroscience", "UCL School of Pharmacy", 'UCL')))
to.combine = c(to.combine, list(c("UCSF School of Dentistry", "USCF", "University of California, San Francisco")))
to.combine = c(to.combine, list(c("Oxford University Clinical Research Unit", "University of Oxford Medical Sciences Division", "University of Oxford")))
to.combine = c(to.combine, list(c("University of Iowa Carver College of Medicine", 'University of Iowa Carver', 'University of Iowa Hospitals and Clinics', 'University of Iowa Healthcare','University of Iowa College of Dentistry',"University of Iowa")))
to.combine = c(to.combine, list(c("Albert Einstein College of Medicine of Yeshiva University", "Yeshiva University")))
to.combine = c(to.combine, list(c('University Cincinnati College of Medicine','University of Cincinnati Academic Health Center', "University of Cincinnati College of Medicine", 'University of Cincinnati Academic Health Center','University Cincinnati','University of Cincinnati')))
to.combine = c(to.combine, list(c("University of Dundee College of Medicine, Dentistry and Nursing", 'University of Dundee')))
to.combine = c(to.combine, list(c("University of Edinburgh, College of Medicine and Veterinary Medicine", 'University of Edinburgh')))
to.combine = c(to.combine, list(c("Michigan State University, College of Human Medicine" , 'Michigan State University')))
to.combine = c(to.combine, list(c("Molecular and Behavioral Neuroscience Institute, University Michigan Ann Arbor", 'University of Michigan Health System', 'University of Michigan Hospital', 'University Michigan Ann Arbor', 'University of Michigan-Flint', 'University of Michigan School of Dentistry', 'University of Michigan Comprehensive Cancer Center', 'University of Michigan')))
to.combine = c(to.combine, list(c("University of Arizona College of Nursing", 'University of Arizona Cancer Center','University of Arizona')))
to.combine = c(to.combine, list(c("King Saud University Medical College","King Saud University College of Applied Medical Sciences","King Saud University")))
to.combine = c(to.combine, list(c("Imperial College", "Imperial College Faculty of Medicine", "Imperial College London")))
to.combine = c(to.combine, list(c("UCL", "UCL School of Pharmacy","UCL Institute of Child Health","UCL Institute of Education","UCL Medical School","UCL Institute of Neurology","University College London")))
to.combine = c(to.combine, list(c("University of Queensland, Centre for Clinical Research", "University of Queensland")))
to.combine = c(to.combine, list(c("Children's Hospital At Westmead, Centre for Kidney Research" , "Children's Hospital At Westmead")))
to.combine = c(to.combine, list(c('McGill University, Douglas Mental Health University Institute','McGill University, Montreal Neurological Institute and Hospital', "McGill University Health Centre, Montreal General Hospital", "McGill University Health Centre, Montreal", "McGill University"))) 
to.combine = c(to.combine, list(c("Biomedical Research Centre in Mental Health Network (CIBERSAM) G16", "Biomedical Research Centre in Mental Health Network (CIBERSAM) G10", "Biomedical Research Centre in Mental Health Network (CIBERSAM)"))) 
to.combine = c(to.combine, list(c("University of Newcastle upon Tyne,", "Newcastle University, United Kingdom", "University of Newcastle"))) # comma in first is sic    
to.combine = c(to.combine, list(c('Academic Medical Centre, University of Amsterdam','University of Amsterdam')))
to.combine = c(to.combine, list(c("Mayo Clinic Scottsdale-Phoenix, Arizona", "Mayo Clinic Hospital", "Mayo Graduate School", "Mayo Clinic in Jacksonville, Florida", "Mayo Medical Schoo", "Mayo Clinic")))
to.combine = c(to.combine, list(c("UNSW, National Drug and Alcohol Research Centre", "UNSW, National Drug & Alcohol Research Centre", "UNSW Australia", "University of New South Wales (UNSW) Australia", "University of New South Wales"))) # would prefer 'Australia' tag, but kept with Leiden
to.combine = c(to.combine, list(c('University of Ottawa Heart Institute', 'University of Ottawa, Canada', 'University of Ottawa'))) 
to.combine = c(to.combine, list(c("Columbia University Division of Cardiology", "Columbia University in the City of New York", "Columbia University, College of Physicians and Surgeons", "Columbia University Medical Center", "Columbia University Division of Cardiac Surgery", "Columbia University College of Dental Medicine", "Columbia University")))
to.combine = c(to.combine, list(c("Tel Aviv University, Sackler", "Tel Aviv University")))
to.combine = c(to.combine, list(c('Hofstra North Shore-Long Island Jewish','North Shore-Long Island Jewish Health System')))
to.combine = c(to.combine, list(c('Mercer University at Atlanta','Mercer University')))
to.combine = c(to.combine, list(c('Lorraine University','Université de Lorraine')))
to.combine = c(to.combine, list(c('Dresden University','Technische Universitat Dresden')))
to.combine = c(to.combine, list(c('University Heart Center Freiburg', "Universitat Freiburg im Breisgau", 'University of Freiburg')))
to.combine = c(to.combine, list(c('University Hospital of the Paracelsus Medical University Salzburg','Paracelsus Medical University')))
to.combine = c(to.combine, list(c('Monash University Malaysia','Monash University')))
to.combine = c(to.combine, list(c('Macquarie University, Australian School of Advanced Medicine', 'Macquarie University')))
to.combine = c(to.combine, list(c('Flinders University of South Australia','Flinders University')))
to.combine = c(to.combine, list(c('Charles Sturt University, Wagga Wagga','Charles Sturt University')))
to.combine = c(to.combine, list(c('Gold Coast University Hospital Southport','Gold Coast Hospital')))
to.combine = c(to.combine, list(c('King Saud University College of Pharmacy','King Saud University')))
to.combine = c(to.combine, list(c('University of Nottingham Malaysia Campus','University of Nottingham')))
to.combine = c(to.combine, list(c('University of Strathclyde Institute of Global Public Health at iPRI','University of Strathclyde Institute of Global Public Health at the International Prevention Research Institute','University of Strathclyde')))
to.combine = c(to.combine, list(c('University of Kentucky College of Pharmacy','University of Kentucky HealthCare',"University of Kentucky Children's Hospital",'University of Kentucky')))
to.combine = c(to.combine, list(c('University of Southern Denmark, Esbjerg','University of Southern Denmark, Sonderborg','University of Southern Denmark')))
to.combine = c(to.combine, list(c('Duke Medicine and Duke Institute for Brain Sciences','Duke University Medical Center','Duke University School of Medicine','Duke University Health System','Duke University')))
to.combine = c(to.combine, list(c('Western University Canada','Western University')))
to.combine = c(to.combine, list(c('University of Tennessee College of Medicine Chattanooga','University of Tennessee, Chattanooga'))) # Three unis in system, Knoxville and University of Tennessee Health Science Center
to.combine = c(to.combine, list(c('Northwestern University Feinberg','Northwestern University')))
to.combine = c(to.combine, list(c('Ohio State University Comprehensive Cancer Center','Ohio State University')))
to.combine = c(to.combine, list(c('Marquette University School of Dentistry','Marquette University')))
to.combine = c(to.combine, list(c('University of British Columbia Okanagan','University of British Columbia')))
to.combine = c(to.combine, list(c('Louisiana State University in Shreveport','Louisiana State University')))
to.combine = c(to.combine, list(c('University of Connecticut Health Center','University of Connecticut')))
to.combine = c(to.combine, list(c('University of Virginia Health System','University of Virginia')))
to.combine = c(to.combine, list(c('Stanford University Medical Center','Stanford University')))
to.combine = c(to.combine, list(c('University of Alabama, Birmingham','University of Alabama at Birmingham')))
to.combine = c(to.combine, list(c('Tufts University School of Dental Medicine','Tufts University')))
to.combine = c(to.combine, list(c('West Virginia University Robert C. Byrd Health Sciences Center','West Virginia University')))
to.combine = c(to.combine, list(c('Washington State University Vancouver','Washington State University Pullman','Washington State University')))
to.combine = c(to.combine, list(c('Washington University School of Medicine in St. Louis','Washington University in St. Louis','Washington University in St. Louis, George Warren Brown School of Social Work','Washington University, St. Louis')))
to.combine = c(to.combine, list(c('Warren Alpert Medical School of Brown University','Brown University Center for Alcohol and Addiction Studies','Brown University')))
to.combine = c(to.combine, list(c('University of Maryland School of Social Work','University of Maryland Medical Center','University of Maryland Medical System',"University of Maryland", 'University of Maryland, College Park'))) # this is separate: 'University of Maryland, Baltimore'
to.combine = c(to.combine, list(c('Oregon Health and Science University Knight Cardiovascular Institute','Oregon Health and Science University')))
to.combine = c(to.combine, list(c('Oklahoma State University System','Oklahoma State University Medical Center','Oklahoma State University - Center for Health Sciences','Oklahoma State University','Oklahoma State University - Stillwater')))
to.combine = c(to.combine, list(c('Rush University Medical Center','Rush University College of Nursing','Rush University')))
to.combine = c(to.combine, list(c('Vanderbilt University Medical Center','Vanderbilt University')))
to.combine = c(to.combine, list(c('University of North Carolina School of Dentistry','University of North Carolina at Chapel Hill','University of North Carolina System','University of North Carolina at Greensboro','University of North Carolina at Charlotte','University of North Carolina Wilmington','University of North Carolina Project-China','University of North Carolina')))
to.combine = c(to.combine, list(c("University of North Dakota School of Medicine and Health Sciences", 'University of North Dakota')))
to.combine = c(to.combine, list(c("University of Western Australia Faculty of Medicine and Dentistry", "University of Western Australia")))
to.combine = c(to.combine, list(c('University of Southern California/Norris Comprehensive Cancer Center','University of Southern California')))
to.combine = c(to.combine, list(c('Baylor University Medical Center at Dallas','Baylor University')))
to.combine = c(to.combine, list(c('University of Utah Health Sciences','University of Utah Health','University of Utah')))
to.combine = c(to.combine, list(c('University of New Mexico Health Sciences Center','University of New Mexico')))
to.combine = c(to.combine, list(c('Virginia Commonwealth University Health System','Virginia Commonwealth University')))
to.combine = c(to.combine, list(c('Thomas Jefferson University Hospital','Thomas Jefferson University')))
to.combine = c(to.combine, list(c("Purdue University Weldon School of Biomedical Engineering", "Purdue University, Lafayette")))
to.combine = c(to.combine, list(c('Islamic Azad University, Lahijan Branch','Islamic Azad University, Science and Research Branch','Islamic Azad University, Tehran Medical Branch','Islamic Azad University, Tehran Dental Branch','Islamic Azad University')))
to.combine = c(to.combine, list(c('University of Miami Leonard M. Miller','University of Miami')))
to.combine = c(to.combine, list(c('University of Florida College of Dentistry','University of Florida')))
to.combine = c(to.combine, list(c('Georgetown University Hospital','Georgetown University Medical Center','Georgetown University')))
to.combine = c(to.combine, list(c('University of Louisville Health Sciences Center','University of Louisville')))
to.combine = c(to.combine, list(c('Weill Cornell Medical College','Weill Cornell Medicine Feil Family Brain and Mind Research Institute','Weill Cornell Medicine','Weill Cornell Medical Center','Weill Cornell Medicine-Qatar','Weill Cornell','Weill Cornell Medical College')))
to.combine = c(to.combine, list(c('Creighton University School of Pharmacy and Health Professions','Creighton University Medical Center','Creighton University')))
to.combine = c(to.combine, list(c('Marshall University Joan C. Edwards','Marshall University')))
to.combine = c(to.combine, list(c("Universidad Autonoma de Barcelona, Facultad de Medicina", "Universitat Auténoma de Barcelona","Universitat Autònoma de Barcelona")))
to.combine = c(to.combine, list(c('Touro University - Nevada','Touro University')))
to.combine = c(to.combine, list(c('Archbold Medical Group/Florida State University','Florida State University')))
to.combine = c(to.combine, list(c('Arizona State University at the Downtown Phoenix Campus','Arizona State University')))
to.combine = c(to.combine, list(c('University of Rochester School of Medicine and Dentistry','University of Rochester Medical Center','University of Rochester')))
to.combine = c(to.combine, list(c('University of Chicago Pritzker School of Medicine','NORC at the University of Chicago','University of Chicago')))
to.combine = c(to.combine, list(c('University of Kansas School of Medicine - Wichita', 'University of Kansas Lawrence', 'University of Kansas Medical Center', 'University of Kansas')))  
to.combine = c(to.combine, list(c('University of Massachusetts Lowell','University of Massachusetts System','University of Massachusetts Boston','University of Massachusetts','University of Massachusetts Amherst')))
to.combine = c(to.combine, list(c('Northeastern University','Northeastern University China')))
to.combine = c(to.combine, list(c('Purdue University Calumet','Purdue University')))
to.combine = c(to.combine, list(c('Rocky Mountain University of Health Care Professions','Rocky Mountain University of Health Professions')))
to.combine = c(to.combine, list(c("North China University of Science and Technology Affiliated Hospital", "North China University of Science and Technology")))
to.combine = c(to.combine, list(c('University of Mississippi Medical Center','University of Mississippi')))
to.combine = c(to.combine, list(c('University of Toledo Medical Center','University of Toledo')))
to.combine = c(to.combine, list(c('Colorado State University-Pueblo','Colorado State University')))
to.combine = c(to.combine, list(c("University of Hawaii at Manoa John A. Burns","University of Hawaii, Manoa","University of Hawaii at Manoa")))
to.combine = c(to.combine, list(c('A.T. Still University, Kirksville','A.T. Still University')))
to.combine = c(to.combine, list(c('University of Minnesota Medical Center, Fairview','University of Minnesota Twin Cities','University of Minnesota','University of Minnesota System'))) # 
to.combine = c(to.combine, list(c('University of Missouri System','University of Missouri'))) 
to.combine = c(to.combine, list(c("St. Luke's University Health Network","St. Luke's University Hospital")))
to.combine = c(to.combine, list(c('California State University Monterey Bay','California State University Long Beach','California State University Dominguez Hills','California State University Fullerton','California State University')))
to.combine = c(to.combine, list(c('Montana State University - Bozeman','Montana State University')))
to.combine = c(to.combine, list(c('University of South Florida Tampa','University of South Florida Health','University of South Florida St. Petersburg', 'University of South Florida')))
to.combine = c(to.combine, list(c("Saint Michael's Hospital University of Toronto","University Health Network University of Toronto","Hospital for Sick Children University of Toronto","Mount Sinai Hospital of University of Toronto","Princess Margaret Hospital University of Toronto","Toronto Health Economics and Technology Assessment Collaborative University of Toronto","Toronto Western Hospital University of Toronto","Ontario Cancer Institute University of Toronto","Lunenfeld-Tanenbaum Research Institute of University of Toronto","Toronto Western Research Institute University of Toronto","Toronto General Research Institute University of Toronto","University of Toront","Li Ka Shing Knowledge Institute","University of Toronto")))
to.combine = c(to.combine, list(c('University of Alberta Hospital','University of Alberta')))
to.combine = c(to.combine, list(c('University of Saskatchewan, Western College of Veterinary Medicine','University of Saskatchewan')))
to.combine = c(to.combine, list(c('University of Prince Edward Island Atlantic Veterinary College','University of Prince Edward Island')))
to.combine = c(to.combine, list(c('King Abdulaziz University Hospital Jeddah','King Abdulaziz University')))
to.combine = c(to.combine, list(c('Kobenhavns Universitet','Copenhagen Centre for Disaster Research','Copenhagen University Hospital','University of Copenhagen')))
to.combine = c(to.combine, list(c('Keio University Hospital','Keio University')))
to.combine = c(to.combine, list(c('Teikyo University Hospital','Teikyo University')))
to.combine = c(to.combine, list(c('Kyoto University Hospital','Kyoto University')))
to.combine = c(to.combine, list(c('University of Mie','Mie University Hospital','Mie University')))
to.combine = c(to.combine, list(c('Hiroshima University Hospital','Hiroshima University')))
to.combine = c(to.combine, list(c('Saitama Medical University Hospital','Saitama Medical Center, Saitama Medical University','Saitama Medical University')))
to.combine = c(to.combine, list(c('Nagoya City University Hospital','Nagoya City University Graduate','Nagoya City University')))
to.combine = c(to.combine, list(c('Yokohama City University Hospital','Yokohama City Graduate','Yokohama City University')))
to.combine = c(to.combine, list(c('Shinshu University Hospital','Shinshu University Faculty of Medicine','Shinshu University')))
to.combine = c(to.combine, list(c('Tokushima University Hospital','Tokushima University')))
to.combine = c(to.combine, list(c('Tottori University Hospital','Tottori University')))
to.combine = c(to.combine, list(c('Kitasato University Hospital','Kitasato University')))
to.combine = c(to.combine, list(c('Hokkaido University Hospital','Hokkaido University')))
to.combine = c(to.combine, list(c('Juntendo University Shizuoka Hospital','Juntendo University')))
to.combine = c(to.combine, list(c('Kyushu Dental University','Kyushu University')))
to.combine = c(to.combine, list(c('EHFRE International University/ FUCSO','EHFRE International University')))
to.combine = c(to.combine, list(c('Artesis Plantijn University','Artesis Plantijn University College')))
to.combine = c(to.combine, list(c('University of Nairobi College of Health Sciences','University of Nairobi')))
to.combine = c(to.combine, list(c('University Hospital of Athens','University of Athens')))
to.combine = c(to.combine, list(c('University Hospital of Ioannina','University of Ioannina')))
to.combine = c(to.combine, list(c('Urmia University of Medical Sciences','Urmia University')))
to.combine = c(to.combine, list(c("Università degli Studi di Roma \"Foro Italico\"", "Universita degli Studi di Roma Tor Vergata","Universita degli Studi di Roma La Sapienza", "Sapienza University of Rome")))
to.combine = c(to.combine, list(c('UNIGRANRIO','UNIGRANRIO University','Grande Rio University (UNIGRANRIO)')))
to.combine = c(to.combine, list(c('University of Séo Paulo (Universidade de Séo Paulo - USP)','USP-Universidade de Séo Paulo','University of Séo Paulo (FMRP-USP)','University of Séo Paulo')))
to.combine = c(to.combine, list(c('VU University Medical Center, Institute for Cardiovascular Research VU','VU University Medical Center')))
to.combine = c(to.combine, list(c('University Hospital Maastricht','Maastricht University')))
to.combine = c(to.combine, list(c('University of Groningen, University Medical Center Groningen','University of Groningen')))
to.combine = c(to.combine, list(c('Erasmus University Medical Center','Erasmus MC Cancer Institute','Erasmus University Rotterdam')))
to.combine = c(to.combine, list(c('Leiden University Medical Center - LUMC','Leiden University')))
to.combine = c(to.combine, list(c('Radboud University Nijmegen Medical Centre','Radboud University Medical Center','Radboud UMC Nijmegen','Radboud University Nijmegen')))
to.combine = c(to.combine, list(c('Karakter Child and Adolescent Psychiatry University Centre','Karakter Child and Adolescent Psychiatry')))
to.combine = c(to.combine, list(c('Karolinska University Hospital','Karolinska Institutet')))
to.combine = c(to.combine, list(c('Linnaeus University, Vaxjo','Linnaeus University, Kalmar','Linnaeus University')))
to.combine = c(to.combine, list(c('Sun Yat-Sen University Cancer Center','Sun Yat-Sen University')))
to.combine = c(to.combine, list(c('Fudan University Shanghai Medical College','Fudan University Shanghai Cancer Center','Fudan University')))
to.combine = c(to.combine, list(c('Central South University China','Central South University')))
to.combine = c(to.combine, list(c('Daping Hospital, the Third Military Medical University','Third Military Medical University')))
to.combine = c(to.combine, list(c('Hospital of Nanjing Medical University','Nanjing Medical University')))
to.combine = c(to.combine, list(c('Peking University Health Science Center','Peking University')))
to.combine = c(to.combine, list(c('Third Affiliated Hospital of Soochow University','Soochow University')))
to.combine = c(to.combine, list(c('First Affiliated Hospital of Kunming Medical University','1st Affiliated Hospital of Kunming Medical University','Second Affiliated Hospital of Kunming Medical University','Kunming Medical University')))
to.combine = c(to.combine, list(c('Shantou University, Medical College (SUMC)','Shantou University')))
to.combine = c(to.combine, list(c('First Affiliated Hospital of Jinzhou Medical University','Jinzhou Medical University')))
to.combine = c(to.combine, list(c('First Affiliated Hospital of Zhengzhou University','Zhengzhou University')))
to.combine = c(to.combine, list(c('Affiliated Hospital of Guangdong Medical University','Hospital of Guangdong Medical University','Guangdong Medical University')))
to.combine = c(to.combine, list(c('Affiliated Hospital of Guangzhou Medical University','First Affiliated Hospital of Guangzhou Medical University','Third Affiliated Hospital of Guangzhou Medical University','Guangzhou Medical University')))
to.combine = c(to.combine, list(c('Second Affiliated Hospital of Harbin Medical University','First Affiliated Hospital of Harbin Medical University','Harbin Medical University')))
to.combine = c(to.combine, list(c('Affiliated Hospital of Zunyi Medical University','Third Affiliated Hospital of Zunyi Medical University','Zunyi Medical University')))
to.combine = c(to.combine, list(c('Tangdu Hospital, Fourth Military Medical University','Fourth Military Medical University')))
to.combine = c(to.combine, list(c('Affiliated Hospital of Guizhou Medical University','Affiliated Baiyun Hospital of Guizhou Medical University','Guizhou Medical University')))
to.combine = c(to.combine, list(c("Wenzhou Medical University Affiliated Cixi Hospital","Second Affiliated Hospital and Yuying Children's Hospital of Wenzhou Medical University","Yuying Children's Hospital of Wenzhou Medical University","First Affiliated Hospital of Wenzhou Medical University","Second Affiliated Hospital of Wenzhou Medical University","Wenzhou Medical University")))
to.combine = c(to.combine, list(c('Gansu University of Traditional Chinese Medicine','Gansu University of Chinese Medicine')))
to.combine = c(to.combine, list(c('Affiliated Hospital of Binzhou Medical University','Binzhou Medical University Hospital Outpatient Department','Binzhou Medical University Hospital','Binzhou Medical University')))
to.combine = c(to.combine, list(c("Affiliated Hospital of Inner Mongolia Medical University","Second Affiliated Hospital to Inner Mongolia Medical University","Traditional Chinese Medicine Institute of Inner Mongolia Medical University","Second Affiliated Hospital of Inner Mongolia Medical University","First Affiliated Hospital of Inner Mongolia Medical University","Affiliated Cancer Hospital of Inner Mongolia Medical University","Inner Mongolia Medical University")))
to.combine = c(to.combine, list(c("North China University of Science and Technology Affiliated Hospital","Trauma Laboratory of the North China University of Science and Technology","North China University of Science and Technology")))
to.combine = c(to.combine, list(c("First Affiliated Hospital of Gannan Medical University","Gannan Medical University Pingxiang Hospital","Gannan Medical University")))
to.combine = c(to.combine, list(c("University of Applied Sciences and Arts Western Switzerland Valais","University of Applied Sciences and Arts Western Switzerland Valais (HES-SO Valais-Wallis)","University of Applied Sciences and Arts Western Switzerland")))
to.combine = c(to.combine, list(c("Faculdade de Ciencias e Tecnologia, New University of Lisbon",'New University of Lisbon')))
to.combine = c(to.combine, list(c('Arctic University of Norway','UiT The Arctic University of Norway')))
to.combine = c(to.combine, list(c('Bjørknes College','Bjørknes University College')))
to.combine = c(to.combine, list(c('Univesrsity of Benin Teaching Hospital','University of Benin')))
to.combine = c(to.combine, list(c('Obafemi Awolowo University Teaching Hospitals Complex','Obafemi Awolowo University')))
to.combine = c(to.combine, list(c('Hanyang University Guri Hospital','Hanyang University')))
to.combine = c(to.combine, list(c("Seoul National University Bundang Hospital","Seoul National University Hospital","SMG- Seoul National University Boramae Medical Center","Seoul National University")))
to.combine = c(to.combine, list(c('Inha University, Incheon','Inha University')))
to.combine = c(to.combine, list(c('Korea University Medical Center','Korea University')))
to.combine = c(to.combine, list(c('Yonsei University Health System','Yonsei University, Wonju','Yonsei University Wonju Campus','Yonsei University')))
to.combine = c(to.combine, list(c('Ulsan University','University of Ulsan, College of Medicine','University of Ulsan')))
to.combine = c(to.combine, list(c('Gyeongsang National University (GSNU)','Gyeongsang National University')))
to.combine = c(to.combine, list(c('Dongguk University, Gyeongju','Dongguk University, Seoul','Dongguk University Ilsan Hospital','Dongguk University')))
to.combine = c(to.combine, list(c('Hallym University Medical Center','Hallym University')))
to.combine = c(to.combine, list(c('Inje University Paik Hospital','Inje University')))
to.combine = c(to.combine, list(c('Keimyung University, Dongsan Medical Center','Keimyung University')))
to.combine = c(to.combine, list(c('University of Malaya Medical Centre','University of Malaya')))
to.combine = c(to.combine, list(c('SRH University of Applied Health Sciences Gera','SRH University of Applied Health Sciences')))
to.combine = c(to.combine, list(c('Split University Hospital','University of Split')))
to.combine = c(to.combine, list(c('University Hospital of Tampere',"University of Tampere, Medical School",'University of Tampere')))
to.combine = c(to.combine, list(c('Chung Shan Medical University Hospital','Chung Shan Medical University')))
to.combine = c(to.combine, list(c('National Taiwan University Hospital','National Taiwan University')))
to.combine = c(to.combine, list(c('Kaohsiung Medical University Chung-Ho Memorial Hospital','Kaohsiung Medical University')))
to.combine = c(to.combine, list(c('Taipei Tzu Chi Hospital','Tzu Chi University')))
to.combine = c(to.combine, list(c('First Affiliated Hospital of China Medical University','China Medical University Shenyang','First Hospital of China Medical University','Shengjing Hospital of China Medical University','Cancer Hospital of China Medical University','China Medical University Hospital Taichung','China Medical University Taichung','China Medical University')))
to.combine = c(to.combine, list(c('National Cheng Kung University Hospital','National Cheng Kung University')))
to.combine = c(to.combine, list(c('University of Auckland in New Zealand','Medical and Health Sciences, University of Auckland','University of Auckland')))
to.combine = c(to.combine, list(c('Massey University, Auckland','Massey University')))
to.combine = c(to.combine, list(c('University Al-Azhar','Al-Azhar University')))
to.combine = c(to.combine, list(c('Zagazig University Hospitals','Zagazig University')))
to.combine = c(to.combine, list(c('Mansoura University,','Mansoura University, Urology and Nephrology Center','Mansoura University')))
to.combine = c(to.combine, list(c('Belgrade University','University of Belgrade')))
to.combine = c(to.combine, list(c("Sydney Children's Hospitals Network (Randwick and Westmead)","Sydney Children's Hospitals Network")))
to.combine = c(to.combine, list(c('Ramathibodi Hospital, Mahidol University','Mahidol University')))
to.combine = c(to.combine, list(c('Aga Khan University Hospital','Aga Khan University')))
to.combine = c(to.combine, list(c('Tartu University Hospital','University of Tartu')))
to.combine = c(to.combine, list(c('College of Medicine and Health Sciences United Arab Emirates University','United Arab Emirates University')))
to.combine = c(to.combine, list(c('University of Reykjavik','Reykjavik University')))
to.combine = c(to.combine, list(c('University of the West Indies at Cave Hill','University of the West Indies')))
# translations
to.combine = c(to.combine, list(c('Hacettepe Universitesi','Hacettepe University,','Hacettepe University')))
to.combine = c(to.combine, list(c('Ankara Universitesi','Ankara University,','Ankara University')))
to.combine = c(to.combine, list(c('Istanbul Universitesi','Istanbul University, Cerrahpasa','Istanbul University')))
to.combine = c(to.combine, list(c('Trakya Universitesi','Trakya University,','Trakya University')))
to.combine = c(to.combine, list(c('Gazi Universitesi','Gazi University','Gazi University')))
to.combine = c(to.combine, list(c('Ege Universitesi','Ege University')))
to.combine = c(to.combine, list(c("Universitetet i Oslo",'University of Oslo')))
to.combine = c(to.combine, list(c('Göteborg University, Sahlgrenska Academy','Sahlgrenska Universitetssjukhuset','Goteborgs Universitet','Goteborg University, Sahlgrenska Academy','University of Gothenburg'))) 
to.combine = c(to.combine, list(c('Lunds Universitet','Lund University')))
to.combine = c(to.combine, list(c('Umea Universitet','Umea University,','Umea University')))
to.combine = c(to.combine, list(c('Universidad CES','CES University')))
to.combine = c(to.combine, list(c('Universidad El Bosque','El Bosque University')))
to.combine = c(to.combine, list(c('Universidad de Costa Rica','Costa Rica University','University of Costa Rica')))
to.combine = c(to.combine, list(c('Universite de Kinshasa','Kinshasa University')))
to.combine = c(to.combine, list(c('Aalborg Universitet','Aalborg University')))
to.combine = c(to.combine, list(c("Syddansk Universitet",'University of Southern Denmark')))
to.combine = c(to.combine, list(c('Aarhus Universitet','Aarhus University')))
to.combine = c(to.combine, list(c('Danmarks Tekniske Universitet','Technical University of Denmark')))
to.combine = c(to.combine, list(c('Orebro Universitet','Örebro University')))
to.combine = c(to.combine, list(c('Uppsala universitet','Uppsala University')))
to.combine = c(to.combine, list(c('Universitetssjukhuset i Linkoping','Linkoping University','Linköping University')))
to.combine = c(to.combine, list(c('Norges Teknisk-Naturvitenskapelige Universitet','Norwegian University of Science and Technology'))) 
to.combine = c(to.combine, list(c('Universitetet i Bergen','University of Bergen')))
to.combine = c(to.combine, list(c('Universitetet i Tromso','University of Tromso','University of Tromsø')))
to.combine = c(to.combine, list(c('Universitetet i Stavanger','University of Stavanger')))
to.combine = c(to.combine, list(c('Universiteti i Prishtines','University of Pristina')))
to.combine = c(to.combine, list(c('IT-Universitetet i Kobenhavn','IT University of Copenhagen')))
to.combine = c(to.combine, list(c('Universitetet for miljo- og biovitenskap','Norwegian University of Life Sciences')))
to.combine = c(to.combine, list(c('Odense Universitetshospital','Odense University Hospital')))
to.combine = c(to.combine, list(c('Arhus Universitetshospital','Aarhus University Hospital')))
to.combine = c(to.combine, list(c('Vilniaus universitetas','Vilnius University')))
to.combine = c(to.combine, list(c('Faculte de Medecine de Marseille Universite de la Mediterranee','Aix Marseille Universite','University of Aix-Marseille','Aix-Marseille University')))
to.combine = c(to.combine, list(c("Universitat Bielefeld","Universitét Bielefeld","Bielefeld University")))   
to.combine = c(to.combine, list(c("Universidade de Pernambuco, Faculdade de Ciencias Medicas","Universidade de Pernambuco")))
to.combine = c(to.combine, list(c('Universidade do Estado de Santa Catarina','University of State of Santa Catarina','Santa Catarina State University')))
to.combine = c(to.combine, list(c("Universidad de Cordoba", "Universidad de Cordoba, Facultad de Medicina", "University of Córdoba")))
to.combine = c(to.combine, list(c("Centre Hospitalier de L'Universite de Montreal","Universite de Montreal", "Université de Montreál","Université de Montréal",'University of Montreal')))
to.combine = c(to.combine, list(c("Universita Cattolica del Sacro Cuore, Rome, Facolta di Medicina e Chirurgia", "Universita Cattolica del Sacro Cuore, Rome")))
to.combine = c(to.combine, list(c("Universitat de ValEncia", "Universitat de Valencia, Facultad de Medicina y Odontologia", "Universitat de Valencia")))
to.combine = c(to.combine, list(c("Universidad de Valladolid, Facultad de Medicina", "Universidad de Valladolid")))
to.combine = c(to.combine, list(c("Universidad de Valparaiso", "University of Valparaíso")))
to.combine = c(to.combine, list(c("Faculdade de Farmacia, Universidade de Lisboa","Faculdade de Medicina, Universidade de Lisboa","Faculdade de Motricidade Humana, Universidade de Lisboa","Faculdade de Medicina Veterinaria, Universidade de Lisboa","Universidade de Lisboa")))
to.combine = c(to.combine, list(c("d Fédération de Médecine translationnelle de Strasbourg (FMTS)", "Fédération de Médecine Translationnelle de Strasbourg (FMTS)")))
to.combine = c(to.combine, list(c("Barts and The London Queen Mary's School of Medicine and Dentistry", "Queen Mary, University of London", "Queen Mary University of London")))
to.combine = c(to.combine, list(c("Purdue University, Lafayette Weldon School of Biomedical Engineering", "Purdue University, Lafayette"))) # kept separate "Purdue University, Lafayette Calumet")))
to.combine = c(to.combine, list(c('Universitatsklinik Erlangen und Medizinische Fakultat', "Friedrich-Alexander-Universität Erlangen-Nürnberg")))
to.combine = c(to.combine, list(c("Rutgers New Jersey", "Rutgers Robert Wood Johnson","Rutgers Robert Wood Johnson Medical School at New Brunswick", "Rutgers, The State University of New Jersey")))
to.combine = c(to.combine, list(c("UAB Comprehensive Cancer Center", "University of Alabama at Birmingham", "University of Alabama, Birmingham")))
to.combine = c(to.combine, list(c("Samsung Medical Center, Sungkyunkwan University", "Sungkyunkwan University")))
to.combine = c(to.combine, list(c("Royal College of Surgeons of Ireland Affiliated Hospital", "Royal College of Sur. in Ireland", "Royal College of Surgeons in Ireland")))
to.combine = c(to.combine, list(c("Luxembourg Institute of Socio-Economic Research (LISER)", "Luxembourg Institute of Socio-Economic Research")))
to.combine = c(to.combine, list(c("George Institute", "George Institute for Global Health")))
to.combine = c(to.combine, list(c("St George's Hospital, London", "St George's University of London")))
to.combine = c(to.combine, list(c("NYU", 'NYU School of Medicine','NYU Robert F. Wagner Graduate School of Public Service','NYU Silver School of Social Work', "NYU Langone Medical Center", "NYU Lutheran System", "NYU Hospital for Joint Diseases","NYU College of Dentistry", "NYU", "NYU Steinhardt School of Culture, Education, and Human Development", "New York University")))
to.combine = c(to.combine, list(c("VCU School of Dentistry", "VCU", "Virginia Commonwealth University")))
to.combine = c(to.combine, list(c("CASE", "Case Western Reserve University")))
to.combine = c(to.combine, list(c('Radboud University Nijmegen','Radboud University')))
to.combine = c(to.combine, list(c("Universidade Federal do Ceará", "University of Ceara", "Federal University of Ceará")))
to.combine = c(to.combine, list(c("Florey Institute of Neuroscience and Mental Health", 'University of Melbourne')))
to.combine = c(to.combine, list(c("VU University Medical Center", 'VU University Amsterdam')))
to.combine = c(to.combine, list(c('Cancer Council New South Wales','Cancer Council Queensland','Cancer Council SA','Cancer Council Victoria','Cancer Council Australia')))
to.combine = c(to.combine, list(c('Queen Elizabeth Hospital, University Hospital Birmingham NHS Foundation Trust','University Hospitals Birmingham NHS Foundation Trust')))
to.combine = c(to.combine, list(c('Amtssygehuset i Herlev','Herlev Hospital')))
to.combine = c(to.combine, list(c('University of Hawaii System','University of Hawaii')))
to.combine = c(to.combine, list(c("Centre hospitalier pour enfants de l'est de l'Ontario", "Children's Hospital of Eastern Ontario")))
to.combine = c(to.combine, list(c("University of G. d'Annunzio Chieti and Pescara","D'Annunzio University")))
to.combine = c(to.combine, list(c('Collegium Medicum Uniwersytet Jagiellonskiego','Jagiellonian University Medical College')))
to.combine = c(to.combine, list(c('Ita-Suomen yliopisto','University of Eastern Finland')))
to.combine = c(to.combine, list(c("Universitatea de Medicina si Farmacie Carol Davila din Bucuresti",'Carol Davila University of Medicine and Pharmacy')))
to.combine = c(to.combine, list(c("Centro Hospitalar e Universitario de Coimbra", "University of Coimbra")))

# run the combines/changes
standard.ids = NULL
for (k in 1:length(to.combine)){
  # a) do the combining in the papers data
  this = to.combine[[k]]
  this.s = paste('^', this, sep='') # add start and ending to avoid, e.g., "Pasteur Institute" also including ""Pasteur Institute of Iran" 
  this.s = paste(this.s, '$', sep='')  
  index = grep(paste(this.s[1:(length(this)-1)], collapse = '|', sep=''), papers$affiliation)
  if(length(index)>0){
    
    # b) store multiple affiliation IDs for later standard table
    pattern = paste(this.s, collapse = '|', sep='') # search for all versions
    ids = unique(papers$affid[str_detect(pattern=pattern, string=papers$affiliation)])
    if(length(ids) > 0){ # only when there's some match
      ids = ids[is.na(ids) == FALSE] # remove missing
      frame = data.frame(affiliations=as.character(this[length(this)]), affid=ids) # store last name (i.e., changed name) and all IDs
      standard.ids = rbind(standard.ids, frame)
    }
    # replace affilations
    papers$affiliation[index] = this[length(this)] # change to last name in vector
    rm(ids, frame)
  } # end of index if
  rm(index) # tidy up
}

# China medical split by country
index = papers$affiliation=='China Medical University' & papers$country=='Taiwan' & is.na(papers$affiliation)==FALSE & is.na(papers$country)==FALSE
papers$affiliation[index] = 'China Medical University, Taiwan'

# Multiple different countries
index = papers$affiliation=='University of Hong Kong' & is.na(papers$affiliation)==FALSE
papers$country[index] = 'China'

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
# split by missing or now
index = is.na(papers$University) == F
complete = papers[!index,] # was 46061
missing = papers[index,] # was 1817
missing$affiliation = missing$University # overwrite
papers = rbind(complete, missing)
papers = subset(papers, select=-University) # remove no longer needed variable

## blank some daft affiliations
index = papers$affiliation %in% unique( c('Research Unit','Research and Development Unit','Research and Development',
    'Patient Research Partner','Operational Research Unit',
    'Ministry of Health','Medical Affairs Department',
    'Independent Researcher','Independent Consultant','Division of Cardiology',
    'Division of Internal Medicine','Division of Cardiovascular Surgery',
    'College of Medicine','College of Nursing',
    'Cancer Center','Cardiac Surgery Division','Cardiac Surgery Unit',
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
    "Information Specialist \\(consultant\\)" , "Information Specialist Consultant",
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

# fix, switch back wrongly removed suffix
papers$affiliation[papers$affiliation=='Baylor' & is.na(papers$affiliation)==FALSE] = 'Baylor College of Medicine'
# another fix, not sure why this is not working above, something to do with commas?
# fix (accidental drop of Medical School)
papers$affiliation[papers$affiliation=='Hannover' & is.na(papers$affiliation)==FALSE] = "Hannover Medical School"
#  fix (Mayo went wrong despite efforts above)
papers$affiliation[papers$affiliation=='Mayo' & is.na(papers$affiliation)==FALSE] = "Mayo Clinic"
# fix those ending with a comma or space
papers$affiliation = gsub(',$| $', '', papers$affiliation)

# fix wrong countries
papers$country[ grep('GlaxoSmithKline', papers$affiliation)] = 'United States' # Split over lots of countries, consolidated to USA
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
papers$country[ grep('University of Montreal', papers$affiliation)] = 'Canada' # one Colombia
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
papers$country[ grep("Western University", papers$affiliation)] = 'Canada' # couple UK
papers$country[ grep("University of Hong Kong", papers$affiliation)] = 'China' # one USA
papers$country[ grep("National Health Service|NHS", papers$affiliation)] = 'UK' # one Italy
papers$country[ grep("Cornell", papers$affiliation)] = 'UK' # one Qatar

index = papers$country == 'Australia' & papers$affiliation == 'University of Newcastle' & is.na(papers$affiliation)==F
papers$affiliation[index] = 'University of Newcastle, Australia' # Be consistent with country suffix

## fix regions (use given countries to fix regions)
true.regions = read_excel('country.data.xls', skip=2, sheet=1)
for (this.region in unique(true.regions$Region)){
  countries = dplyr::filter(true.regions, Region==this.region)$Country
  index = papers$country %in% countries
  papers$Region[index] = this.region
}

## calculate weight per paper (data is one row per author)
library(dplyr)
papers = group_by(papers, doi) %>% # per paper
  mutate(n.authors = n()) %>%
  mutate(weight = 1/n.authors) %>%
  select(-n.authors) %>%# no longer needed
  ungroup()

## What affilations have more than one affid per affiliation? useful for standard_table.scopus.R
more.than.one = select(papers, affiliation, affid) %>%
  filter(is.na(affiliation) == FALSE) %>% # remove missing
  unique() %>% # just unique combinations
  group_by(affiliation) %>%
  mutate(n=n()) %>% 
  filter(n>1) # more than one affid number

### save ###
papers = ungroup(papers) %>%
  dplyr::select(doi, affiliation, affid, country , year, Region, weight) %>%
  dplyr::filter(year %in% c(2016,2017)) # exclude two papers
save(papers, date.searched, standard.ids, more.than.one, file='Papers.for.Analysis.RData') # 

### other checks ###
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
