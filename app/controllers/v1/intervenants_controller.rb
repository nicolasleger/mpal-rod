class V1::IntervenantsController < ApplicationController
  before_action :set_headers 

  def index
    if (missing_params = [:adresse, :thematiques].keep_if { |param| params[param].blank? }).present?
      return render text: { "error": missing_params.map { |param| "#{param} is missing" }.join(" and ") }.to_json
    end

    departement = nil
    if params[:adresse] =~ /\d{5,}/
      departement = Regexp.last_match[0][0..1]
    end

    return render text: {
      "code_commune": "25411",
      "type_departement": "Non déployé",
      "operateur": OPERATEURS[0..1],
      "service_instructeur": [ INSTRUCTEURS[3] ],
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
      adresse_postale: "1 Rue de Ronde du Fort Griffon, 25000 Besançon",
      email: "demo-pris@anah.gouv.fr",
    }],
    "88" => [{
      raison_sociale: "PRIS-DDT-88",
      id_clavis: 5269,
      adresse_postale: "22-26 Avenue Dutac, 88000 Épinal",
      phone: "03 33 44 55 66",
      email: "pris88@anah.gouv.fr",
    }],
    "95" => [{
      raison_sociale: "ADIL 95",
      id_clavis: 5272,
      adresse_postale: "La Croix Saint-Sylvère, 95000 Cergy",
      email: "pris95@anah.gouv.fr",
    }],
    "31" => [{
      raison_sociale: "PRIS DDT 31",
      id_clavis: 5277,
      email: "pris31@anah.gouv.fr",
    }],
    "62" => [{
      raison_sociale: "PRIS DDT 62",
      id_clavis: 5280,
      adresse_postale: "1 Boulevard de la Marquette, 31090 Toulouse",
      email: "pris62@anah.gouv.fr",
    }],
    "75" => [{
      raison_sociale: "Centre Information Habitat Adil 75",
      themes: ["autonomie", "insalubrité", "énergie"],
      adresse_postale: "13 rue Crespin du Gast, 75011 Paris",
      email: "adil_75@mailinator.com",
    }],
  }

  OPERATEURS = [
    {
      departements: ["25"],
      raison_sociale: "AJJ",
      id_clavis: 5267,
      email: "operateur25-1@anah.gouv.fr",
    },
    {
      departements: ["25", "90"],
      raison_sociale: "SOLIHA 25-90",
      id_clavis: 5262,
      adresse_postale: "30 rue Caporal Peugeot, 25000 Besançon",
      email: "demo-operateur@anah.gouv.fr",
    },
    {
      departements: ["88"],
      raison_sociale: "URBAM CONSEIL SAS",
      id_clavis: 5265,
      adresse_postale: "5 Rue Thiers, 88000 Épinal",
      phone: "03 00 11 22 33",
      email: "operateur88-1@anah.gouv.fr",
    },
    {
      departements: ["88"],
      raison_sociale: "BET Exergie",
      id_clavis: 5270,
      adresse_postale: "2 Route d'Aydoilles, 88600 Fontenay",
      email: "operateur88-2@anah.gouv.fr",
    },
    {
      departements: ["95"],
      raison_sociale: "SOLIHA Paris.Hauts de Seine.Val d'Oise",
      id_clavis: 5271,
      adresse_postale: "Les Châteaux Saint-Sylvère, 95000 Cergy",
      email: "operateur95-1@anah.gouv.fr",
    },
    {
      departements: ["31"],
      raison_sociale: "SOLIHA Haute Garonne",
      id_clavis: 5276,
      adresse_postale: "2 Boulevard Armand Duportal, 31000 Toulouse",
      email: "operateur31-1@anah.gouv.fr",
    },
    {
      departements: ["31"],
      raison_sociale: "URBANIS Toulouse",
      id_clavis: 5274,
      adresse_postale: "60 Boulevard Déodat de Sévérac, 31300 Toulouse",
      email: "operateur31-2@anah.gouv.fr",
    },
    {
      departements: ["62"],
      raison_sociale: "SOLIHA du Pas de Calais",
      id_clavis: 5275,
      adresse_postale: "6 Rue Jean Bodel, 62000 Arras",
      email: "operateur62-1@anah.gouv.fr",
    },
    {
      departements: ["62"],
      raison_sociale: "INHARI",
      id_clavis: 5278,
      adresse_postale: "44 Rue du Champ des Oiseaux, 76000 Rouen",
      email: "operateur62-2@anah.gouv.fr",
    },
  ]

  INSTRUCTEURS = [
    {
      departements: ["25"],
      raison_sociale: "DDT 25",
      id_clavis: 5054,
      email: "demo-delegation@anah.gouv.fr",
      type: "DDT",
    },
    {
      departements: ["88"],
      raison_sociale: "DDT des VOSGES",
      id_clavis: 5119,
      adresse_postale: "22-26 Avenue Dutac, 88000 Épinal",
      phone: "03 99 88 77 66",
      email: "delegation88-1@anah.gouv.fr",
      type: "DDT",
    },
    {
      departements: ["95"],
      raison_sociale: "DDT du Val d'Oise",
      id_clavis: 5123,
      email: "delegation95-1@anah.gouv.fr",
      type: "DDT",
    },
    {
      departements: ["31"],
      raison_sociale: "DDT de Haute-Garonne",
      id_clavis: 5062,
      adresse_postale: "2 Boulevard Armand Duportal, 31000 Toulouse",
      email: "delegation31@anah.gouv.fr",
      type: "DDT",
    },
    {
      departements: ["31"],
      raison_sociale: "Conseil Départemental de la Haute-Garonne",
      id_clavis: 5182,
      email: "delegataire-cd31-1@anah.gouv.fr",
      type: "DLC3",
    },
    {
      departements: ["62"],
      raison_sociale: "Direction Départementale des Territoires et de la Mer du Pas-de-Calais",
      id_clavis: 5093,
      adresse_postale: "8 Rue du Puits d'Amour, 62200 Boulogne-sur-Mer",
      email: "delegation62-1@anah.gouv.fr",
      type: "DDT",
    },
    {
      departements: ["62"],
      raison_sociale: "Communauté Urbaine d'Arras",
      id_clavis: 5226,
      adresse_postale: "Boulevard du Général de Gaulle, 62000 Arras",
      email: "delegataire-Arras62-1@anah.gouv.fr",
      type: "DLC3",
    },
    {
      departements: ["62"],
      raison_sociale: "Communauté d'Agglomération de Béthune-Bruay",
      id_clavis: 5228,
      adresse_postale: "100 Avenue de Londres, 62400 Béthune",
      email: "delegataire-Bethune62-1@anah.gouv.fr",
      type: "DLC2",
    },
  ]

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

