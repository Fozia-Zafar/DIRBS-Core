--
-- DIRBS SQL migration script (v40 -> v41)
--
-- Copyright (c) 2018 Qualcomm Technologies, Inc.
--
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without modification,
-- are permitted (subject to the limitations in the disclaimer below) provided that the
-- following conditions are met:
--
--  * Redistributions of source code must retain the above copyright notice, this list of conditions
--    and the following disclaimer.
--  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions
--    and the following disclaimer in the documentation and/or other materials provided with the distribution.
--  * Neither the name of Qualcomm Technologies, Inc. nor the names of its contributors may be used to endorse
--    or promote products derived from this software without specific prior written permission.
--
-- NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY THIS LICENSE. THIS SOFTWARE IS PROVIDED
-- BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
-- TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
-- THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-- STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
-- EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--

--
-- Add table data_catalog to catalog files seen by DIRBS
--
CREATE TABLE data_catalog (
  file_id BIGSERIAL PRIMARY KEY,
  filename TEXT NOT NULL,
  file_type TEXT NOT NULL,
  compressed_size_bytes BIGINT NOT NULL,
  modified_time TIMESTAMP NOT NULL,
  is_valid_zip BOOLEAN NOT NULL,
  is_valid_format BOOLEAN DEFAULT NULL,
  md5 UUID NOT NULL,
  extra_attributes JSONB NOT NULL DEFAULT '{}'::JSONB,
  first_seen TIMESTAMP NOT NULL,
  last_seen TIMESTAMP NOT NULL
);

CREATE UNIQUE INDEX data_catalog_filename_file_type_idx ON data_catalog(filename, file_type);