class V1::IntervenantsController < ApplicationController
  before_action :set_headers

  def index
    if (missing_params = [:adresse, :thematiques].keep_if { |param| params[param].blank? }).present?
      return render text: { "error": missing_params.map { |param| "#{param} is missing" }.join(" and ") }.to_json
    end

    departement = nil
    if params[:adresse] =~ /\d{5,}/
      code_commune = Regexp.last_match[0]
      departement = Regexp.last_match[0][0..1]
    end

    return render text: {
      "code_commune": code_commune,
      "type_departement": "Non déployé",
      "operateur": OPERATEURS[departement],
      "service_instructeur": INSTRUCTEURS[departement][0],
      "dlc2": [],
      "pris_anah": PRIS[departement],
      "pris_eie": [],
    }.to_json
  end


private
  def set_headers
    response.headers["Content-Type"] = "application/json"
  end

  PRIS = {
    "25" => [{
      raison_sociale: "ADIL 25",
      id_clavis: 5264,
      adresse_postale: {
        adresse1: "1 Rue de Ronde du Fort Griffon",
        adresse2: "",
        adresse3: "",
        code_postal: "25000",
        ville: "Besançon"
      },
      email: "demo-pris@anah.gouv.fr",
      web: "www.adil25.org",
      tel: "03 81 61 92 41"
    }],

    "88" => [{
      raison_sociale: "PRIS-DDT-88",
      id_clavis: 5269,
      adresse_postale: {
        adresse1: "22-26 Avenue Dutac",
        adresse2: "",
        adresse3: "",
        code_postal: "88000",
        ville: "Épinal"
      },
      email: "pris88@anah.gouv.fr",
      tel: "03 33 44 55 66",
      web: "www.adil25.org"
    }],

    "95" => [{
      raison_sociale: "ADIL 95",
      id_clavis: 5272,
      adresse_postale: {
        adresse1: "La Croix Saint-Sylvère",
        adresse2: "",
        adresse3: "",
        code_postal: "95000",
        ville: "Cergy"
      },
      email: "pris95@anah.gouv.fr",
      tel: "03 33 44 55 66",
      web: "www.adil25.org"
    }],

    "31" => [{
      raison_sociale: "PRIS DDT 31",
      id_clavis: 5277,
      adresse_postale: {
        adresse1: "2 Boulevard Armand Duportal",
        adresse2: "",
        adresse3: "",
        code_postal: "31000",
        ville: "Toulouse"
      },
      email: "pris31@anah.gouv.fr",
      tel: "03 33 44 55 66",
      web: "www.adil25.org"
    }],

    "62" => [{
      raison_sociale: "PRIS DDT 62",
      id_clavis: 5280,
      adresse_postale: {
        adresse1: "6 Rue Jean Bodel",
        adresse2: "",
        adresse3: "",
        code_postal: "62000",
        ville: "Arras"
      },
      email: "pris62@anah.gouv.fr",
      tel: "03 33 44 55 66",
      web: "www.adil25.org"
    }],

    "75" => [{
      raison_sociale: "Centre Information Habitat Adil 75",
      adresse_postale: {
        adresse1: "13 rue Crespin du Gast",
        adresse2: "",
        adresse3: "",
        code_postal: "75011",
        ville: "Paris"
      },
      email: "adil_75@mailinator.com",
      tel: "03 33 44 55 66",
      web: "www.adil25.org"
    }],
  }

  OPERATEURS = {
    "25" => [{
      raison_sociale: "AJJ",
      id_clavis: 5267,
      email: "operateur25-1@anah.gouv.fr",
      siret: "30247604900046",
      adresse_postal: {
        adresse: "30 rue du Caporal Peugeot",
        code_postal: "25000",
        ville: "BESANCON"
      },
      tel: "03 81 81 23 33",
      web: "www.soliha.fr"
    },

    {
      raison_sociale: "SOLIHA 25-90",
      id_clavis: 5262,
      email: "demo-operateur@anah.gouv.fr",
      siret: "30247604901036",
      adresse_postal: {
        adresse: "30 rue du Caporal Peugeot",
        code_postal: "25000",
        ville: "BESANCON"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],

    "88" => [{
      raison_sociale: "URBAM CONSEIL SAS",
      id_clavis: 5265,
      email: "operateur88-1@anah.gouv.fr",
      siret: "30247634900036",
      adresse_postal: {
        adresse: "5 rue Thiers BP 450",
        code_postal: "88011",
        ville: "BESEPINAL CEDEX"
      },
      tel: "03 00 11 22 33",
      web: "www.urbam.fr"
    },
    {
      raison_sociale: "BET Exergie",
      id_clavis: 5270,
      email: "operateur88-2@anah.gouv.fr",
      siret: "34758223100168",
      adresse_postal: {
        adresse: "2 Route d'Aydoilles",
        code_postal: "88600",
        ville: "Fontenay"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],
    "95" => [{
      raison_sociale: "SOLIHA Paris.Hauts de Seine.Val d'Oise",
      id_clavis: 5271,
      email: "operateur95-1@anah.gouv.fr",
      siret: "30247604900036",
      adresse_postal: {
        adresse: "Les Châteaux Saint-Sylvère",
        code_postal: "95000",
        ville: "Cergy"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],
    "31" => [{
      raison_sociale: "SOLIHA Haute Garonne",
      id_clavis: 5276,
      email: "operateur31-1@anah.gouv.fr",
      siret: "77557134200077",
      adresse_postal: {
        adresse: "2 Boulevard Armand Duportal",
        code_postal: "31000",
        ville: "Toulouse"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    },
    {
      raison_sociale: "URBANIS Toulouse",
      id_clavis: 5274,
      email: "operateur31-2@anah.gouv.fr",
      siret: "30247604900036",
      adresse_postal: {
        adresse: "60 Boulevard Déodat de Sévérac",
        code_postal: "31300",
        ville: "Toulouse"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],
    "62" => [{
      raison_sociale: "SOLIHA du Pas de Calais",
      id_clavis: 5275,
      email: "operateur62-1@anah.gouv.fr",
      siret: "30247604900036",
      adresse_postal: {
        adresse: "6 Rue Jean Bodel",
        code_postal: "62000",
        ville: "Arras"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    },
    {
      raison_sociale: "INHARI",
      id_clavis: 5278,
      email: "operateur62-2@anah.gouv.fr",
      siret: "30247604900036",
      adresse_postal: {
        adresse: "6 Rue Jean Bodel",
        code_postal: "62000",
        ville: "Arras"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],
  }

  INSTRUCTEURS = {
    "25"=> [{
      raison_sociale: "DDT 25",
      id_clavis: 5054,
      email: "demo-delegation@anah.gouv.fr",
      type: "DDT",
      siret: "30247604900036",
      adresse_postal: {
        adresse1: "30 rue du Caporal Peugeot",
        adresse2: "",
        adresse3: "",
        code_postal: "25000",
        ville: "BESANCON"
      },
      tel: "03 81 81 23 33",
      web: "www.soliha.fr"
    }],

    "88" => [{
      raison_sociale: "DDT des VOSGES",
      id_clavis: 5119,
      adresse_postale: "22-26 Avenue Dutac, 88000 Épinal",
      phone: "03 99 88 77 66",
      siret: "30227604900036",
      email: "delegation88-1@anah.gouv.fr",
      type: "DDT",
      adresse_postal: {
        adresse1: "5 rue Thiers BP 450",
        adresse2: "",
        adresse3: "",
        code_postal: "88011",
        ville: "BESEPINAL CEDEX"
      },
      tel: "03 00 11 22 33",
      web: "www.urbam.fr"
    }],

    "95" => [{
      raison_sociale: "DDT du Val d'Oise",
      id_clavis: 5123,
      email: "delegation95-1@anah.gouv.fr",
      siret: "30247604900037",
      type: "DDT",
      adresse_postal: {
        adresse1: "Les Châteaux Saint-Sylvère",
        adresse2: "",
        adresse3: "",
        code_postal: "95000",
        ville: "Cergy"
      },
      tel: "04 37 28 79 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],

    "31" => [{
      raison_sociale: "DDT de Haute-Garonne",
      id_clavis: 5062,
      email: "delegation31@anah.gouv.fr",
      type: "DDT",
      siret: "30247604900036",
      adresse_postal: {
        adresse1: "2 Boulevard Armand Duportal",
        adresse2: "",
        adresse3: "",
        code_postal: "31000",
        ville: "Toulouse"
      },
      tel: "04 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    },
    {
      raison_sociale: "Conseil Départemental de la Haute-Garonne",
      id_clavis: 5182,
      email: "delegataire-cd31-1@anah.gouv.fr",
      type: "DLC3",
      siret: "30247604500036",
      adresse_postal: {
        adresse1: "2 Boulevard Armand Duportal",
        adresse2: "",
        adresse3: "",
        code_postal: "31000",
        ville: "Toulouse"
      },
      tel: "04 27 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],

    "62" => [{
      raison_sociale: "Direction Départementale des Territoires et de la Mer du Pas-de-Calais",
      id_clavis: 5093,
      email: "delegation62-1@anah.gouv.fr",
      type: "DDT",
      siret: "30248604900036",
      adresse_postal: {
        adresse1: "8 Rue du Puits d'Amour",
        adresse2: "",
        adresse3: "",
        code_postal: "62200",
        ville: "Boulogne-sur-Mer"
      },
      tel: "06 37 28 70 20",
      web: "www.rhonegrandlyon.soliha.fr"
    },
    {
      raison_sociale: "Communauté Urbaine d'Arras",
      id_clavis: 5226,
      adresse_postale: ", 62000 Arras",
      email: "delegataire-Arras62-1@anah.gouv.fr",
      type: "DLC3",
      siret: "30248604900176",
      adresse_postal: {
        adresse1: "Boulevard du Général de Gaulle",
        adresse2: "",
        adresse3: "",
        code_postal: "62000",
        ville: "Arras"
      },
      tel: "04 37 28 70 30",
      web: "www.rhonegrandlyon.soliha.fr"
    },
    {
      raison_sociale: "Communauté d'Agglomération de Béthune-Bruay",
      id_clavis: 5228,
      email: "delegataire-Bethune62-1@anah.gouv.fr",
      type: "DLC2",
      siret: "30246704900176",
      adresse_postal: {
        adresse1: "100 Avenue de Londres",
        adresse2: "",
        adresse3: "",
        code_postal: "62400",
        ville: "Béthune"
      },
      tel: "04 37 28 80 20",
      web: "www.rhonegrandlyon.soliha.fr"
    }],
  }

  SIEGES = [
    {
      departements: [],
      raison_sociale: "ANAH Siège SSI",
      id_clavis: 5001,
      adresse_postale: "",
      email: "referent-ssi@anah.gouv.fr",
      type: "siege"
    },
    {
      departements: [],
      raison_sociale: "ANAH Siège PART",
      id_clavis: 5251,
      adresse_postale: "",
      email: "conseiller-part@anah.gouv.fr",
      type: "siege"
    },
  ]

  DREALS = [
    {
      departements: ["21", "25", "39", "58", "70", "71", "89", "90"],
      raison_sociale: "DREAL Bourgogne France-Comté",
      id_clavis: 5268,
      adresse_postale: "",
      email: "dreal-bourgogne-franchecomte@anah.gouv.fr",
      type: "dreal"
    },
    {
      departements: ["75", "77", "78", "91", "92", "93", "94", "95"],
      raison_sociale: "DREAL Ile-de-France",
      id_clavis: 5025,
      adresse_postale: "",
      email: "drihl-ile-de-france-@anah.gouv.fr",
      type: "dreal"
    },
    {
      departements: ["9", "11", "12", "30", "31", "32", "34", "46", "48", "65", "66", "81", "82"],
      raison_sociale: "DREAL Occitanie",
      id_clavis: 5273,
      adresse_postale: "",
      email: "dreal-occitanie@anah.gouv.fr",
      type: "dreal"
    },
    {
      departements: ["2", "59", "60", "62", "80"],
      raison_sociale: "DREAL Hauts de France",
      id_clavis: 5279,
      adresse_postale: "",
      email: "dreal-hauts-de-france@anah.gouv.fr",
      type: "dreal"
    },
  ]
end
