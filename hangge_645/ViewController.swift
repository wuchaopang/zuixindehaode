import UIKit

class ViewController: UIViewController {
          @IBAction func chazhao(sender: AnyObject) {
        initUser()
    }
    
      @IBAction func shanchu(sender: AnyObject) {
        
    }
    @IBAction func saveClicked(sender: AnyObject) {
        saveUser()
    }
    func saveUser() {
        let uname = self.txtUname.text!
        let mobile = self.txtMobile.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into user(uname,mobile) values('\(uname)','\(mobile)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }
    
    var db:SQLiteDB!
    
    @IBOutlet weak var x: UITextView!
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表
        db.execute("create table if not exists user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        //如果有数据则加载
        initUser()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

       //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["mobile"] as? String
        }
        
        for var i=1;i<data.count;i++
        {
         var user=data[i]
            x.text! += "\(i)"
            x.text!+="用户名"+String(user["uname"]!) + "电话"+String(user["mobile"]!)+"\n"
           // print(x)
        }
}
}