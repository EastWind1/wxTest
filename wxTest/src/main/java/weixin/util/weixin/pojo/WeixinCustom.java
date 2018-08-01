package weixin.util.weixin.pojo;
/**
 * 客服实体类
 * @author 东风
 *
 */
public class WeixinCustom {
	//客服账号
	private String kf_account;
	//客服昵称
	private String nickname;
	//客服密码
	private String password;
	//客服微信号
	private String invite_wx;
	public String getKf_account() {
		return kf_account;
	}
	public void setKf_account(String kf_account) {
		this.kf_account = kf_account;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getInvite_wx() {
		return invite_wx;
	}
	public void setInvite_wx(String invite_wx) {
		this.invite_wx = invite_wx;
	}
}
