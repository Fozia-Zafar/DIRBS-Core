--
-- DIRBS SQL migration script (v41 -> v42)
--
-- Copyright (c) 2018 Qualcomm Technologies, Inc.
--
--  All rights reserved.
--
--
--
--  Redistribution and use in source and binary forms, with or without modification, are permitted (subject to the
--  limitations in the disclaimer below) provided that the following conditions are met:
--
--
--  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
--  disclaimer.
--
--  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
--  disclaimer in the documentation and/or other materials provided with the distribution.
--
--  * Neither the name of Qualcomm Technologies, Inc. nor the names of its contributors may be used to endorse or promote
--  products derived from this software without specific prior written permission.
--
--  NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY THIS LICENSE. THIS SOFTWARE IS PROVIDED BY
--  THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
--  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
--  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
--  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
--  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
--  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
--  POSSIBILITY OF SUCH DAMAGE.
--

--
-- Add a new column to the schema_version table describing whether we have upgraded this schema
-- to remove bad IMSIs and MSISDNs
--
ALTER TABLE schema_version ADD COLUMN potential_whitespace_imsis_msisdns BOOLEAN NOT NULL DEFAULT TRUE;

--
-- Rename the schema_version table to schema_metadata
--
ALTER TABLE schema_version RENAME TO schema_metadata;

--
-- Create a view alias from the old name to the new to make upgrade seamless
--
CREATE VIEW schema_version AS SELECT version FROM schema_metadata WITH CHECK OPTION;
