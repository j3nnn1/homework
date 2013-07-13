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

import org.apache.orp.util.TrecQrel;
import org.apache.orp.util.TrecQrelWriter;

public class OhsumedQrelConverter {
  
  public static void main(String[] args) throws Exception {
    if (args.length == 0) {
      System.err.println("Usage: OhsumedQrelConverter <inputQrels> <outputQrels>");
      System.err.println("\tinputQrels\tone of the qrels.mesh.* or qrels.ohsu.* files from OHSUMED");
      System.err.println("\toutputQrels\toutput file (will be silently overwritten if exists!)");
      System.exit(-1);
    }
    BufferedReader in = new BufferedReader(new InputStreamReader(
            new FileInputStream(args[0]), "UTF-8"));
    TrecQrelWriter writer = new TrecQrelWriter(new File(args[1]));
    TrecQrel qrel = new TrecQrel();
    
    String line = null;
    while ((line = in.readLine()) != null) {
      String[] fields = line.split("\\s+");
      if (fields.length < 2) {
        System.err.println("-invalid line, skiping: " + line);
        continue;
      }
      qrel.setDocno(fields[1]);
      qrel.setIter("0");
      qrel.setQid(fields[0]);
      if (fields.length > 2) {
        qrel.setRel(Integer.parseInt(fields[2]));
      } else {
        qrel.setRel(1);
      }
      writer.write(qrel);
    }
    in.close();
    writer.close();
  }
}
