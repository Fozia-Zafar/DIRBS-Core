"""
DIRBS REST-ful db_metadata API module.

Copyright (c) 2018 Qualcomm Technologies, Inc.

 All rights reserved.



 Redistribution and use in source and binary forms, with or without modification, are permitted (subject to the
 limitations in the disclaimer below) provided that the following conditions are met:


 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
 disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
 disclaimer in the documentation and/or other materials provided with the distribution.

 * Neither the name of Qualcomm Technologies, Inc. nor the names of its contributors may be used to endorse or promote
 products derived from this software without specific prior written permission.

 NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY THIS LICENSE. THIS SOFTWARE IS PROVIDED BY
 THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
"""

from flask import jsonify
from marshmallow import Schema, fields

from dirbs.api.common.db import get_db_connection
import dirbs.utils as utils
from dirbs import db_schema_version as code_db_schema_version
from dirbs import __version__ as dirbs_core_version
from dirbs import report_schema_version


def api():
    """DB metadata API endpoint."""
    with get_db_connection() as db_conn:
        return jsonify(
            Version().dump(
                dict(source_code_version=dirbs_core_version,
                     code_db_schema_version=code_db_schema_version,
                     db_schema_version=utils.query_db_schema_version(db_conn),
                     report_schema_version=report_schema_version)).data)


class Version(Schema):
    """Defines the Version schema."""

    source_code_version = fields.String()
    code_db_schema_version = fields.Integer()
    db_schema_version = fields.Integer()
    report_schema_version = fields.Integer()
