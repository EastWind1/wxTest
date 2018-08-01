package weixin.util.weixin.message.resp;

/**
 * 视频消息
 * 

 * @date 2013-09-11
 */
public class VideoMessage extends BaseMessage {
	// 视频
	private Video Video;

	public Video getVideo() {
		return Video;
	}

	public void setVideo(Video video) {
		Video = video;
	}
}
