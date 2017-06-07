DROP VIEW IF EXISTS openchpl.certified_product_search;
CREATE OR REPLACE VIEW openchpl.certified_product_search AS

SELECT
    cp.certified_product_id,
    string_agg(DISTINCT certs.cert_number::text, '☺') as "certs",
    string_agg(DISTINCT cqms.cqm_number::text, '☺') as "cqms",
    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
	cp.meaningful_use_users,
	cp.transparency_attestation_url,
    edition.year,
    atl.testing_lab_name,
    acb.certification_body_name,
    cp.acb_certification_id,
    prac.practice_type_name,
    version.product_version,
    product.product_name,
    vendor.vendor_name,
    string_agg(DISTINCT history_vendor_name::text, '☺') as "owner_history",
    certStatusEvent.certification_date,
    certStatus.certification_status_name,
	decert.decertification_date,
	string_agg(DISTINCT certs_with_api_documentation.cert_number::text||'☹'||certs_with_api_documentation.api_documentation, '☺') as "api_documentation",
    COALESCE(survs.count_surveillance_activities, 0) as "surveillance_count",
    COALESCE(nc_open.count_open_nonconformities, 0) as "open_nonconformity_count",
    COALESCE(nc_closed.count_closed_nonconformities, 0) as "closed_nonconformity_count"
 FROM openchpl.certified_product cp
	LEFT JOIN (SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id",
			cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse
				INNER JOIN (
					SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id
				) cseInner 
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) certStatusEvents
		ON certStatusEvents.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) certStatus on certStatusEvents.certification_status_id = certStatus.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id
    LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id" FROM openchpl.vendor 
			JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
			WHERE product_owner_history_map.deleted = false) owners
    ON owners.history_product_id = product.product_id
    LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" 
		FROM openchpl.surveillance 
		WHERE openchpl.surveillance.deleted <> true  
		GROUP BY certified_product_id) survs
    ON cp.certified_product_id = survs.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_nonconformities" 
		FROM openchpl.surveillance surv
		JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
		JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
		JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
		WHERE surv.deleted <> true 
		AND nc_status.name = 'Open'  
		GROUP BY certified_product_id) nc_open
    ON cp.certified_product_id = nc_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_nonconformities" 
		FROM openchpl.surveillance surv
		JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
		JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
		JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
		WHERE surv.deleted <> true 
		AND nc_status.name = 'Closed'  
		GROUP BY certified_product_id) nc_closed
    ON cp.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT number as "cert_number", certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true AND certification_result.deleted = false AND certification_criterion.deleted = false) certs
	ON certs.certified_product_id = cp.certified_product_id
	LEFT JOIN (SELECT number as "cert_number", api_documentation, certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true 
		AND certification_result.api_documentation IS NOT NULL 
		AND certification_result.deleted = false 
		AND certification_criterion.deleted = false) certs_with_api_documentation
	ON certs_with_api_documentation.certified_product_id = cp.certified_product_id 
    LEFT JOIN (SELECT COALESCE(cms_id, 'NQF-'||nqf_number) as "cqm_number", certified_product_id FROM openchpl.cqm_criterion 
		JOIN openchpl.cqm_result 
		ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
		WHERE cqm_result.success = true AND cqm_result.deleted = false AND cqm_criterion.deleted = false) cqms
	ON cqms.certified_product_id = cp.certified_product_id
	
WHERE cp.deleted != true
GROUP BY cp.certified_product_id, cp.acb_certification_id, edition.year, atl.testing_lab_code, acb.certification_body_code, vendor.vendor_code, cp.product_code, cp.version_code,cp.ics_code, cp.additional_software_code, cp.certified_date_code, cp.transparency_attestation_url,
atl.testing_lab_name, acb.certification_body_name,prac.practice_type_name,version.product_version,product.product_name,vendor.vendor_name,certStatusEvent.certification_date,certStatus.certification_status_name, decert.decertification_date,
survs.count_surveillance_activities, nc_open.count_open_nonconformities, nc_closed.count_closed_nonconformities
;

------------------------------------------------------------
-- Bulk change ICSA Listings Disclosure URLs
------------------------------------------------------------
-- obtained list of CP ids from REST API. This list excludes non-managed ICSA listings
BEGIN;
	WITH updated_rows AS (
		UPDATE openchpl.certified_product
		SET transparency_attestation_url = 'https://www.cerner.com/cehrt-disclosure-information'
		WHERE certification_body_id = 6
		AND certified_product_id IN (5415,5419,5423,5427,5431,5435,5439,5443,5455,5459,5463,5490,5494,5498,5502,5506,5510,5514,5518,5522,5526,5530,5550,5558,5562,5566,5570,5571,5579,5582,5586,5590,5594,5598,5602,5606,5610,5614,5617,5620,5623,5626,5629,5632,5635,5638,5639,5641,5644,5647,5650,5653,5656,5680,5681,5683,5684,5686,5689,5692,5701,5704,5707,5730,5733,5740,5743,5746,5748,5749,5751,5752,5754,5755,5757,5758,5760,5761,5763,5764,5766,5767,5769,5770,5772,5773,5775,5776,5778,5779,5781,5782,5784,5785,5787,5788,5789,5790,5791,5793,5794,5795,5796,5797,5799,5800,5802,5803,5806,5809,5812,5815,5816,5818,5821,5824,5827,5830,5833,5839,5842,5845,5854,5857,5860,5861,5863,5866,5868,5869,5871,5872,5874,5876,5877,5879,5880,5882,5883,5885,5886,5888,5889,5891,5892,5894,5895,5897,5900,5903,5906,5909,5912,5915,5921,5924,5927,5928,5929,5930,5932,5933,5935,5936,5942,5948,5950,5953,5956,5958,5959,5962,5965,5968,5970,5971,5973,5975,5976,5977,5979,5980,5981,5982,5983,5985,5986,5988,5989,5991,5992,5994,5995,5997,5998,6000,6001,6003,6004,6005,6006,6007,6008,6009,6010,6011,6012,6013,6014,6015,6016,6017,6018,6019,6020,6021,6022,6023,6024,6025,6026,6028,6031,6032,6034,6035,6036,6037,6038,6039,6040,6041,6042,6043,6045,6046,6048,6049,6051,6052,6054,6055,6057,6058,6060,6061,6064,6065,6066,6068,6069,6071,6072,6074,6075,6077,6080,6083,6087,6113,6122,6123,6128,6129,6143,6146,6149,6152,6153,6155,6156,6158,6159,6160,6161,6162,6163,6164,6165,6166,6167,6168,6169,6170,6171,6172,6173,6174,6175,6176,6178,6179,6181,6182,6184,6185,6187,6188,6190,6191,6193,6196,6200,6203,6206,6212,6215,6218,6220,6221,6222,6223,6224,6226,6227,6228,6229,6230,6231,6232,6233,6234,6235,6236,6237,6238,6239,6241,6242,6244,6246,6247,6248,6249,6250,6251,6252,6253,6254,6255,6265,6267,6269,6271,6273,6275,6277,6278,6279,6280,6281,6282,6283,6284,6288,6289,6290,6291,6292,6294,6295,6297,6313,6315,6317,6319,6321,6323,6329,6331,6333,6335,6339,6341,6343,6345,6347,6349,6351,6353,6371,6373,6375,6377,6379,6381,6382,6383,6385,6387,6389,6391,6393,6403,6405,6407,6409,6411,6413,6415,6416,6418,6419,6421,6422,6424,6426,6427,6428,6430,6432,6434,6436,6438,6440,6442,6444,6445,6446,6448,6450,6452,6454,6455,6456,6457,6459,6461,6463,6465,6467,6469,6471,6474,6476,6477,6478,6479,6480,6481,6483,6485,6487,6489,6491,6493,6495,6497,6499,6505,6507,6509,6512,6514,6516,6518,6520,6521,6522,6523,6524,6526,6528,6530,6532,6548,6550,6552,6554,6556,6558,6560,6564,6584,6588,6590,6591,6592,6593,6595,6596,6598,6599,6600,6601,6602,6604,6605,6606,6607,6608,6610,6611,6612,6614,6616,6620,6624,6626,6630,6631,6632,6633,6634,6635,6637,6639,6641,6643,6645,6647,6648,6649,6650,6651,6652,6654,6656,6658,6659,6660,6661,6662,6663,6664,6665,6666,6667,6668,6669,6670,6671,6673,6675,6677,6679,6704,6725,6727,6729,6731,6764,6770,6772,6774,6817,6835,6839,6842,6843,6844,6847,6848,6849,6857,6858,6863,6864,6865,6866,6867,6868,6869,6870,6871,6884,6885,6886,6887,6888,6889,6890,6892,6893,6894,6895,6896,6897,6898,6899,6900,6901,6902,6903,6904,6905,6906,6907,6908,6909,6910,6911,6912,6913,6914,6915,6916,6918,6919,6920,6921,6924,6925,6948,6949,6950,6951,6952,6953,6954,6955,6956,6957,6958,6959,6960,6961,6962,6963,6964,6965,6966,6967,6968,6969,6970,6971,6972,6973,6974,6975,6976,6977,6978,6979,6980,6981,6982,6983,6984,6985,6986,6987,6988,6989,6990,6991,6992,6993,6994,6995,6996,6997,6998,6999,7000,7001,7002,7003,7004,7005,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018,7019,7020,7021,7022,7023,7024,7025,7026,7027,7028,7029,7030,7031,7032,7033,7034,7035,7036,7037,7038,7039,7040,7041,7042,7043,7044,7045,7046,7047,7048,7049,7050,7051,7052,7053,7054,7055,7056,7057,7058,7059,7060,7061,7062,7063,7064,7065,7066,7067,7068,7069,7070,7071,7072,7111,7114,7121,7122,7124,7125,7126,7127,7128,7129,7132,7133,7136,7137,7138,7139,7140,7141,7142,7143,7144,7145,7146,7147,7148,7149,7150,7151,7152,7153,7154,7155,7157,7159,7160,7161,7162,7163,7164,7165,7166,7173,7174,7175,7176,7177,7178,7179,7180,7181,7182,7183,7184,7185,7186,7187,7188,7191,7192,7193,7194,7195,7196,7197,7198,7201,7202,7203,7204,7205,7207,7208,7209,7210,7211,7212,7213,7214,7215,7216,7217,7218,7219,7223,7224,7225,7227,7228,7229,7230,7231,7232,7233,7234,7235,7236,7237,7238,7262,7263,7264,7269,7280,7281,7283,7284,7285,7286,7287,7288,7289,7290,7291,7292,7293,7294,7295,7296,7297,7298,7299,7304,7312,7343,7345,7347,7348,7349,7350,7351,7352,7353,7354,7355,7356,7357,7358,7359,7361,7362,7363,7364,7365,7366,7367,7368,7369,7370,7371,7372,7373,7374,7375,7376,7377,7378,7379,7380,7381,7382,7383,7384,7385,7386,7387,7388,7389,7390,7393,7394,7395,7396,7397,7425,7429,7430,7431,7432,7433,7434,7435,7436,7437,7438,7439,7440,7441,7442,7443,7445,7446,7447,7448,7449,7450,7451,7452,7453,7454,7455,7456,7457,7458,7459,7460,7461,7462,7464,7465,7466,7467,7482,7483,7484,7485,7486,7487,7488,7489,7490,7491,7492,7493,7494,7495,7496,7497,7498,7499,7500,7501,7502,7503,7504,7505,7506,7507,7508,7509,7510,7511,7512,7514,7515,7516,7517,7518,7519,7520,7521,7522,7523,7524,7525,7526,7527,7528,7529,7530,7531,7539,7542,7544,7546,7557,7558,7559,7560,7561,7562,7563,7566,7567,7568,7569,7570,7571,7572,7573,7574,7575,7576,7577,7578,7579,7580,7581,7582,7583,7584,7585,7586,7587,7588,7589,7590,7591,7592,7593,7595,7596,7597,7598,7599,7600,7601,7602,7603,7604,7626,7627,7628,7629,7648,7649,7650,7651,7652,7653,7654,7655,7656,7657,7658,7659,7660,7661,7662,7663,7664,7665,7666,7667,7668,7669,7670,7672,7673,7674,7675,7676,7677,7678,7679,7682,7683,7684,7685,7686,7687,7688,7751,7752,7753,7754,7755,7756,7757,7758,7864,7865,7866,7867,7868,7869,7870,7871,7872,7873,7874,7875,7876,7877,7878,7879,7880,7881,7882,7883,7884,7885,7886,7887,7888,7889,7890,7891,7892,7893,7894,7895,7896,7897,7898,7899,7900,7901,7902,7903,7904,7905,7906,7907,7908,7909,7910,7911,7912,7913,7914,7915,7916,7917,7918,7919,7920,7921,7922,7923,7924,7925,7926,7927,7928,7929,7930,7931,7932,7933,7934,7935,7936,7937,7938,7939,7977,7993,7994,7995,7996,7997,7998,7999,8000,8002,8003,8004,8015,8016,8017,8018,8019,8020,8021,8022,8023,8024,8025,8026,8027,8028,8029,8030,8031,8032,8093,8094,8095,8096,8099,8100,8101,8102,8103,8104,8145,8150,8151,8152,8153,8154,8155,8156,8157,8158,8159,8160,8161,8162,8163,8164,8165,8166,8167,8197,8198,8199,8200,8201,8202,8261,8262,8264,8265,8266,8267,8268,8269,8270,8271,8272,8273,8274,8275,8276,8277,8278,8279,8280,8297,8298,8301,8302,8303,8304,8305,8306,8307,8308,8309,8310,8313,8314,8315,8339,8340,8382,8383,8384,8385,8386,8387,8388,8389,8390,8391,8392,8393,8394,8395,8396,8397,8398,8399,8400,8401,8402,8403,8404,8405,8406,8407,8408,8409,8410,8411,8412,8413,8414,8415,8416,8417,8418,8419,8420,8421,8422,8423,8424,8425,8426,8427,8428,8429,8430,8431,8432,8433,8434,8435,8436,8437,8438,8439,8440,8441,8442,8443,8444,8445,8446,8447,8448,8449,8450,8451,8452,8453,8456,8457,8458,8459,8460,8488)
		RETURNING certified_product_id, transparency_attestation_url
	)
	SELECT count(DISTINCT certified_product_id) FROM updated_rows;
COMMIT;
-- should update 1,341 listings' Tranparency Attestation URL

\i dev/openchpl_grant-all.sql