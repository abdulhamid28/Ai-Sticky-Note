import 'dart:convert';
import 'package:http/http.dart' as Http;

class RequestResponse{
  String ApiKey =
  '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';
  //'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';     // todo : expired
      //'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'; // todo : expired
     // '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'; // todo : expired
      //'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'; // todo : expired
  String baseUrl='https://api.openai.com/v1/chat/completions'; // todo : expired
  
   ApiCallForChatGpt({required String promtptForGpt}) async {
     var response = await Http.post(     // request type is Http Post
         Uri.parse(baseUrl),
         headers: {
            'Content-Type' : 'application/json',  // what type of data is sent in body
            'Authorization' : 'Bearer $ApiKey'   //Api key for Authorisation
         },
       //   body: jsonEncode({
       //      'model': 'text-davinci-003',  // Model which im using here is text-davinsi-003
       //      'prompt': promtptForGpt,      // the question which is sent to server side
       //      'max_tokens': 50,            // maximum token that can be generated as tokens
       //      'temperature': 0.2,             // varies from 0-2 (0 --very accurate  2 --very random)
       //      'top_p': 1,
       // })
       body:  jsonEncode(
           {
             "model": "gpt-3.5-turbo",
             "messages": [
               // {
               //   "role": "system",
               //   "content": promtptForGpt
               // },
               {
                 "role" : 'user',
                 "content" : promtptForGpt
               }
             ],
             "temperature": 1,
             "max_tokens": 256,
             "top_p": 1,
             "frequency_penalty": 0,
             "presence_penalty": 0
           }
       )
     );
     // print(response.body);
     if(response.statusCode==200){
         var RawData = jsonDecode(response.body.toString());
         String responseFromGpt = RawData['choices'][0]['message']['content'];
          // print(responseFromGpt);
         return responseFromGpt;
     }else{
       return 'Sorry we are currently facing this issue : ${response.body}';
     }

  }


}