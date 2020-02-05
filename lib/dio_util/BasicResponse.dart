class BasicResponse {
    dynamic data;
    int code;
    String detailMsg;
    String msg;

    BasicResponse({this.data, this.code, this.detailMsg, this.msg});

    factory BasicResponse.fromJson(Map<String, dynamic> json) {
        return BasicResponse(
            data: json['data'],
            code: json['code'], 
            detailMsg: json['detailMsg'], 
            msg: json['msg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['data'] = this.data;
        data['code'] = this.code;
        data['detailMsg'] = this.detailMsg;
        data['msg'] = this.msg;
        return data;
    }
}