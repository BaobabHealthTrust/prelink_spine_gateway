require 'pre_link_service'

class PatientsController < ApplicationController
  before_filter :prelink_connect, :except => [:void]
  
  def order_request
    @patient = Spine::Patient.find(params[:id]) rescue nil

    redirect_to "/" if @patient.nil?
    
    @name = @patient.person.name rescue ""

    @first_name = @patient.person.names.first.given_name rescue ""
    @last_name = @patient.person.names.first.family_name rescue ""
    @national_id = @patient.national_id(false) # rescue ""
    @age = @patient.person.age rescue ""
    @dob = @patient.person.birthdate rescue ""
    @gender = @patient.person.gender rescue ""

    # tmp = @prelink.get_test_codes

    # @codes = [""]

    # tmp.each do |key, value|
    #  @codes << [key, value] if !value.blank?
    # end

    @codes = {
      "FNA Gram Stain" => ["Gram GNB","Gram GNC","Gram GNCB","Gram GNDC","Gram GPB",
        "Gram GPC","Gram GPDC","Gram NOS","Gram YEA"],
      "Liver Enzymes" => ["Alkaline Phosphatase","ALT","AST","GGT","LDH"],
      "Urine Microscopy" => ["Schistosomiasis","Trichomonas Vaginalis","Urine RBC",
        "Urine WBC","Yeast Cells"],
      "U&Es (Urea & Electrolytes, renal function)" => ["Calcium","Chloride","CO2 ","NA",
        "Potassium","Urea"],
      "Bilirubin profile" => ["Bilirubin Direct","Bilirubin Indirect","Bilirubin Total"],
      "CSF CHEM" => ["CSF Glucose","CSF micro-protein"],
      "BC Adult" => ["BCULT ADULT"],
      "Mycobacterial blood culture" => ["Mycobacterial BC","Mycobacterial BC Time"],
      "Stool M&C" => ["Cryptosporidium oocysts","Stool Appearance"],
      "HIV DNA PCR" => ["HIV DNA PCR","HIV DNA PCR Confirmatory"],
      "Lipogram" => ["Cholesterol","HDL Cholesterol","LDL Cholesterol","Triglycerides"],
      "Malaria Thin film" => ["Blood parasite (non-Malaria)",
        "Mal P falciparum gametocyte parasitaemia","Mal P falciparum gametocytes",
        "Mal P falciparum merozoites","Mal P falciparum schizonts",
        "Mal P falciparum troph count per 200 WBCs","Mal P falciparum trophs",
        "Mal P falciparum trophs/microL (RBC)","Mal P falciparum trophs/microL (WBC)",
        "Mal P falciparum trophs/500 RBCs","Mal P Malariae gametocytes",
        "Mal P Malariae merozoites","Mal P Malariae schizonts","Mal P Malariae trophs",
        "Mal P Ovale gametocytes","Mal P Ovale merozoites","Mal P Ovale schizonts",
        "Mal P Ovale trophs","Mal P Vivax gametocytes","Mal P Vivax merozoites",
        "Mal P Vivax schizonts","Mal P Vivax trophs"],
      "CSF MC&S Procedure" => ["Appearance","CSF Indian Ink","Gram"],
      "CD4 (FACSCount)" => ["CD4 Absolute","CD4/CD8","CD8 Absolute","Total CD3 Average"],
      "Calcium" => ["Albumin","Calcium"],
      "TB Microscopy & Culture" => ["TB Culture Identification","TB Culture Sputum",
        "TB Smear Microscopy(AFB) sputum"],
      "BC Paediatric" => ["BCULT blood weight","BCULT bottle weight Post",
        "BCULT bottle weight Pre","BCULT PAED","BCULT Paeds BC bottle label"],
      "CDC Flu" => ["CDC FLU A ","CDC FLU B","CDC H1N1 sw","CDC H5N1"],
      "Malaria Thick Screen" => ["Malaria Thick Film","Thick Smear Parasitaemia"],
      "Pleural fluid M,C&S procedure" => ["Appearance","Glucose Pleural fluid","Gram","Protein Pleural"],
      "Syphilis serology" => ["TPPA FUJIREBIO"],
      "U&E and Creatinine" => ["Creatinine"],
      "Micro Other" => ["B-LACT","ESBL"],
      "LEUKOCYTE MORPHOLOGY WORKSHEET" => ["LM Basophils Abs","LM Comment",
        "LM Eosinophils Abs","LM Epithelial Cells/HPF","LM Erythrocyte Cells/HPF",
        "LM Lymphocytes Abs","LM Macro Abs","LM Neutrophils Abs"],
      "AFB Profile" => ["TB Smear Microscopy(AFB) sputum"],
      "RPR" => ["RPR (TITRE)","RPR QUAL"],
      "Selective salmonella culture, BM" => ["ESBL","MIC CIP"],
      "Total Protein" => ["Albumin","Protein Total"],
      "Selective Salmonella Culture, HS" => ["ESBL","MIC CIP"],
      "TSH,FT4" => ["Free T4","TSH"],
      "Microscopy" => ["Lymphs","Polymorphs","RCC","WBC"],
      "CT/NG Abbott" => ["CT Abbott PCR","NG Abbott PCR"],
      "Electrolytes" => ["Chloride","CO2 ","NA","Potassium"],
      "CD4 Profile" => ["CD 45","CD4 %","CD4 - bead events","CD4 Aq Time",
        "CD4 Bead count","CD4 CHECK0","CD4 CHECK1","CD4 CHECK2","CD4 COLCOMP",
        "CD4 color","CD4 Count","CD4/CD8","CD8 %","CD8 Count"],
      "Gram Stain" => ["Gram GNB","Gram GNC","Gram GNCB","Gram GNDC","Gram GPB",
        "Gram GPC","Gram GPDC","Gram NOS","Gram YEA"],
      "BM GRAM" => ["BM Gram GNB","BM Gram GNC","BM Gram GNCB","BM Gram GNDC",
        "BM Gram GPB","BM Gram GPC","BM Gram GPDC","BM Gram YEA"],
      "FTD Resp." => ["Adenovirus","Bocavirus","C.pneumoniae","CorHKU","CoronaVirus 229",
        "CoronaVirus 43","CoronaVirus 63","Enterovirus","FTD Bordetella","FTD CMV",
        "FTD FLU A","FTD FLU B","FTD FLU C","FTD H1N1 sw","FTD Haem inf sp",
        "FTD K. pneumo","FTD Legionella","FTD Moraxella","FTD PCP","FTD Salmonella",
        "H.Influenzae B","M.pneumoniae","Metapneumo","Paraflu1","ParaFlu2","ParaFlu3",
        "ParaFlu4","Parechovirus","Rhinovirus","RSV","S.aureus","S.pneumoniae PCR"],
      "LEUKOCYTE MORPHOLOGY PROFILE" => ["LM Basophils %","LM Basophils Abs",
        "LM Comment","LM Eosinophils %","LM Eosinophils Abs","LM Epithelial Cells/HPF",
        "LM Erythrocyte Cells/HPF","LM Lymphocytes %","LM Lymphocytes Abs","LM Macro %",
        "LM Macro Abs","LM Neutrophils %","LM Neutrophils Abs"],
      "LFT" => ["ALT","AST","Bilirubin Direct","Bilirubin Total","GGT"],
      "BCULT GRAM" => ["BCULT Gram GNB","BCULT Gram GNC","BCULT Gram GNCB",
        "BCULT Gram GNDC","BCULT Gram GPB","BCULT Gram GPC","BCULT Gram GPDC","BCULT Gram YEA"],
      "FBC (Full Blood Count)" => ["Basophils#","Basophils%","Eosinophils#","Eosinophils%",
        "Haematocrit","Haemoglobin","Lymphocytes#","Lymphocytes%","MCH","MCHC","MCV",
        "Monocytes#","Monocytes%","MPV","Neutrophils#","Neutrophils%","Platelets",
        "RDW","Red Cell Count","WCC "],
      "Gene Xpert" => ["Gene Xpert MTB sputum","Gene Xpert Rif sputum"],
      "HbA1c" => ["Haemoglobin A1c (CX5)","Haemoglobin Hb (CX5)","HbA1c (IFCC)","HbA1c (NGSP)"],
      "Micro Other MC&S Procedure" => ["Appearance","Gram"],
      "Hepatitis screen" => ["Hepatitis B Surface Antigen (RT)","Hepatitis C  (RT)"],
      "Manual Differential" => ["Basophils#","Basophils%","Blasts#","Blasts%","Eosinophils#",
        "Eosinophils%","Lymphocytes#","Lymphocytes%","Metamyelocytes %","Metamyelocytes#",
        "Monocytes#","Monocytes%","Myelocytes#","Myelocytes%","Neutrophils#",
        "Neutrophils%","Promyelocytes %","Promyelocytes#","Stab#","Stab%","WCC Man"],
      "Selective Salmonella culture, stool" => ["ESBL","MIC CIP"]}

  end

  def place_order
    options = {
      :priority_code => params["PriorityCode"],
      :date_collected => params["DateCollected"],
      :date_received => params["DateCollected"],
      :folio_number => params["FolioNumber"],
      :first_name => params["FirstName"],
      :last_name => params["LastName"],
      :national_id => params["NationalId"],
      :age => params["Age"],
      :dob => params["Dob"],
      :gender => params["Gender"],
      :doctor_location_code => params["DoctorLocationCode"],
      :test_codes => (params["TestCodes"] rescue [])
    }

    @order = LabOrder.create(
      :national_id => params["NationalId"],
      :priority_code => params["PriorityCode"],
      :date_collected => params["DateCollected"],
      :date_received => params["DateReceived"],
      :patient_id => params["PatientId"],
      :test_code => params["TestCodes"].join("|")
    )

    @result = @prelink.order_request(options)

    @order.update_attributes(
      :request_number => @result[:request_number],
      :barcodes => @result[:barcodes]
    )

    redirect_to "/show/#{@order.patient_id}"

  end

  def show    
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @name = @patient.person.name rescue ""

    @first_name = @patient.person.names.first.given_name rescue ""
    @last_name = @patient.person.names.first.family_name rescue ""
    @national_id = @patient.national_id_with_dashes(false) rescue ""
    @age = @patient.person.age rescue ""
    @dob = @patient.person.birthdate rescue ""
    @gender = @patient.person.gender rescue ""

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ?", @patient.id]) rescue []

    @open = []
    @closed = []

    @orders.each do |order|
      if order.result.blank?
        @open << order
      else
        @closed << order
      end
    end

    @cancel_destination_root_url =
      YAML.load_file("#{Rails.root}/config/application.yml")["#{Rails.env}"]["cancel_destination_root_url"] rescue ""
    
  end

  def overview
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @name = @patient.person.name rescue ""

    @first_name = @patient.person.names.first.given_name rescue ""
    @last_name = @patient.person.names.first.family_name rescue ""
    @national_id = @patient.national_id_with_dashes(false) rescue ""
    @age = @patient.person.age rescue ""
    @dob = @patient.person.birthdate rescue ""
    @gender = @patient.person.gender rescue ""

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ? AND DATE(timestamp) = ?",
        @patient.id, (session[:datetime] ? session[:datetime].to_date.strftime("%Y-%m-%d") :
            Date.today.strftime("%Y-%m-%d"))]) rescue []
    
    tmp = @prelink.get_test_codes

    @codes = {}

    tmp.each do |key, value|
      @codes[value] = key if !value.blank?
    end

    render :layout => false
  end

  def orders
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ?", @patient.id]) rescue []

    @open = []

    @orders.each do |order|
      if order.result.blank?
        @open << order
      end
    end

    @codes = {}

    tmp = @prelink.get_test_codes

    tmp.each do |key, value|
      @codes[value] = key if !value.blank?
    end

    render :layout => false
  end

  def results
    @patient = Spine::Patient.find(params[:id]) rescue nil

    @orders = LabOrder.find(:all, :conditions => ["patient_id = ?", @patient.id]) rescue []

    @closed = []

    @orders.each do |order|
      if !order.result.blank?
        @closed << order
      end
    end

    @codes = {}

    tmp = @prelink.get_test_codes

    tmp.each do |key, value|
      @codes[value] = key if !value.blank?
    end

    render :layout => false
  end

  def check_results
    results = @prelink.get_new_results

    results.each do |result|
      order = LabOrder.find_by_request_number(result[:request_number]) rescue nil

      order.update_attributes(
        :result => result[:result],
        :test_unit => result[:test_unit],
        :colour => result[:colour],
        :date_result_received => Time.now
      ) if !order.nil?
    end    

    @new_results = results.length rescue 0
    
    # render :text => results.length rescue 0
  end

end
