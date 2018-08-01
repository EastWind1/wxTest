package weixin.util;
//订单状态常量
public class OrderState {
	public static final String WAIT_RECEIVE="1";//已发布，未接单
	
	public static final String WAIT_CONFIME="2";//已发布，已被(多方)接单，需确认

	public static final String ONGOING="3";//已接单，服务方服务进行中

	public static final String WAIT_PAY="4";//待付款

	public static final String WAIT_EVALUATE="5";//已完成，未评价

	public static final String COMPLETE="6";//已完成，已评价

	public static final String WAIT_SERVER_RECEIVE="7";//定向订单等待确认

	public static final String REFUSED="8";//定向订单被拒

}
