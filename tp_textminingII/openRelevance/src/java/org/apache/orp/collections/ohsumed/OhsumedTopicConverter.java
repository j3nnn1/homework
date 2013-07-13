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

import org.apache.orp.util.TrecTopic;
import org.apache.orp.util.TrecTopicWriter;

public class OhsumedTopicConverter {
  
  public static void main(String[] args) throws Exception {
    if (args.length == 0) {
      System.err.println("Usage: OhsumedTopicConverter <inputTopics> <outputTopics>");
      System.err.println("\tinputTopics\tone of the query.mesh.* or query.ohsu.* files from OHSUMED");
      System.err.println("\toutputTopics\toutput file (will be silently overwritten if exists!)");
      System.exit(-1);
    }
    BufferedReader in = new BufferedReader(new InputStreamReader(
            new FileInputStream(args[0]), "UTF-8"));
    TrecTopicWriter writer = new TrecTopicWriter(new File(args[1]));
    TrecTopic topic = new TrecTopic();
    topic.setNarrative(""); // no narratives
    
    String line = null;
    boolean description = false;
    while ((line = in.readLine()) != null) {
      String lineT = line.trim();
      if (lineT.equals("") || lineT.equals("</top>")) {
        continue;
      }
      if (line.trim().equals("<top>")) { // output existing doc & reset
        if (topic.getNumber() != null && !topic.getNumber().equals("")) {
          writer.write(topic);
        }
        topic.setNumber("");
        topic.setDescription("");
        topic.setTitle("");
        continue;
      }
      if (lineT.startsWith("<num> Number: ")) {
        topic.setNumber(lineT.substring(14));
      } else if (lineT.startsWith("<title> ")) {
        topic.setTitle(line.substring(8));
      } else if (lineT.equals("<desc> Description:")) {
        description = true;
        continue;
      } else if (description) {
        topic.setDescription(line);
        description = false;
      } else {
        System.err.println("Unrecognized line, skipping: '" + line + "'");
        continue;
      }
    }
    // output last topic if present
    if (!topic.getNumber().equals("")) {
      writer.write(topic);
    }
    in.close();
    writer.close();
  }
}
