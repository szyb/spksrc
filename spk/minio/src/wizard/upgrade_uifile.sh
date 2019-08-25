#!/bin/sh

INST_ETC="/var/packages/${SYNOPKG_PKGNAME}/etc"
INST_VARIABLES="${INST_ETC}/installer-variables"

# Reload wizard variables stored by postinst
if [ -r "${INST_VARIABLES}" ]; then
    . "${INST_VARIABLES}"
fi

cat <<EOF > $SYNOPKG_TEMP_LOGFILE
[
	{
		"step_title": "MinIO configuration",
		"items": [
		  {
			"type": "textfield",
			"subitems": [
			  {
				"key": "wizard_data_directory",
				"desc": "Data directory location",
				"defaultValue": "${WIZARD_DATA_DIRECTORY}",
				"validator": {
				  "allowBlank": false,
				  "regex": {
					"expr": "/^\\\/volume[0-9]{1,2}\\\/[^<>: */?\"]*/",
					"errorText": "Path should begin with /volume?/ where ? is volume number (1-99)"
				  }
				}
			  },
			  {
				"key": "wizard_access_key",
				"desc": "MinIO access key",
				"defaultValue": "${WIZARD_ACCESS_KEY}",
				"validator": {
				  "allowBlank": false,
				  "minLength": 3,
				  "regex": {
					"expr": "/^[^<>:*/?\"|]*$/",
					"errorText": "Not allowed character in key"
				  }
				}
			  },
			  {
				"key": "wizard_secret_key",
				"desc": "MinIO secret key",
				"defaultValue": "${WIZARD_SECRET_KEY}",
				"validator": {
				  "allowBlank": false,
				  "minLength": 8,
				  "regex": {
					"expr": "/^[^\"|]*$/",
					"errorText": "Not allowed character in key"
				  }
				}
			  }
			]
		  }
		]
	},
	{
		"step_title": "Attention! DSM6 Permissions",
		"items": [{
			"desc": "Permissions for this package are handled by the <b>'sc-minio'</b> group. <br>Using File Station, add this group to every folder minio should be allowed to access.<br>Please read <a <a target=\"_blank\" href=\"https://github.com/SynoCommunity/spksrc/wiki/Permission-Management\">Permission Management</a> for details."
		}]
	}
]
EOF
exit 0
