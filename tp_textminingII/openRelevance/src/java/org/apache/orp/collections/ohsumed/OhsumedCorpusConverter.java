package org.apache.orp.collections.ohsumed;
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import org.apache.orp.util.TrecDocument;
import org.apache.orp.util.TrecDocumentWriter;

public class OhsumedCorpusConverter {
  
  private static final String OHSU_SEQID = ".I "; // the only single-line field
  private static final String OHSU_DOCID = ".U";
  private static final String OHSU_SUBJECT = ".S";
  private static final String OHSU_MESH = ".M";
  private static final String OHSU_TITLE = ".T";
  private static final String OHSU_TYPE = ".P";
  private static final String OHSU_BODY = ".W";
  private static final String OHSU_AUTHORS = ".A";
  
  private static final HashSet<String> multiLine = new HashSet<String>();
  static {
    multiLine.add(OHSU_DOCID);
    multiLine.add(OHSU_SUBJECT);
    multiLine.add(OHSU_MESH);
    multiLine.add(OHSU_TITLE);
    multiLine.add(OHSU_TYPE);
    multiLine.add(OHSU_BODY);
    multiLine.add(OHSU_AUTHORS);
  }
  
  private static TrecDocument doc = new TrecDocument();
  private static Date date = new Date(); // this corpus does not have a date, use a fake one.
  
  public static void main(String[] args) throws Exception {
    if (args.length == 0) {
      System.err.println("Usage: OhsumedCorpusConverter <inputFile> <outputFile>");
      System.err.println("\tinputFile\tone of the ohsumed.87 or ohsumed.88-91 files");
      System.err.println("\toutputFile\toutput to store the converted corpus. NOTE: will be silently overwritten if exists!");
      System.exit(-1);
    }
    BufferedReader in = new BufferedReader(new InputStreamReader(
            new FileInputStream(args[0]), "UTF-8"));
    TrecDocumentWriter writer = new TrecDocumentWriter(new File(args[1]));
    
    String line = null;
    String did = null;
    StringBuilder body = new StringBuilder();
    HashMap<String, StringBuilder> fields = new HashMap<String, StringBuilder>();
    String curField = null;
    while ((line = in.readLine()) != null) {
      if (line.startsWith(OHSU_SEQID)) { // new document
        if (!fields.isEmpty()) {
          writeDocument(fields, writer);
          fields.clear();
        }
        fields.put(OHSU_SEQID, new StringBuilder(line.substring(OHSU_SEQID.length())));
      } else {
        if (line.charAt(0) == '.' && Character.isUpperCase(line.charAt(1))) { // field id, for multi-line fields
          line = line.trim();
          if (multiLine.contains(line)) {
            curField = line;
          } else {
            System.err.println("Invalid field name: " + line + ", skipping ...");
            curField = null;
          }
          continue;
        } else {
          // value of the current field
          StringBuilder sb = fields.get(curField);
          if (sb == null) {
            sb = new StringBuilder();
            fields.put(curField, sb);
          } else {
            sb.append('\n');
          }
          sb.append(line);
        }
      }
    }
    if (!fields.isEmpty()) {
      writeDocument(fields, writer);
    }
    in.close();
    writer.close();
  }
  
  // for now glue title + body + authors - this is primitive, but probably
  // better than ignoring everything except the body ...
  private static void writeDocument(Map<String, StringBuilder> fields, TrecDocumentWriter writer) throws Exception {
    // Note: some document have an empty body
    StringBuilder body = fields.get(OHSU_BODY);
    StringBuilder title = fields.get(OHSU_TITLE);
    if (title != null) {
      if (body != null) title.append('\n').append(body);
      body = title;
    }
    StringBuilder authors = fields.get(OHSU_AUTHORS);
    if (authors != null) {
      body.append('\n').append(authors);
    }
    StringBuilder mesh = fields.get(OHSU_MESH);
    if (mesh != null) {
      body.append('\n').append(mesh);
    }
    doc.setBody(body);
    doc.setDate(date);
    StringBuilder docName = fields.get(OHSU_DOCID);
    if (docName == null) {
      System.err.println("-Empty docid - skipping ...");
      return;
    }
    doc.setDocname(docName);
    writer.write(doc);
  }

}
