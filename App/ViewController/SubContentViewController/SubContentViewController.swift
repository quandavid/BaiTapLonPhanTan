//
//  SubContentViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit
import SocketIO
import PDFGenerator

class SubContentViewController: AppViewController {
    @IBOutlet var titleLabel: UILabel!
    //MARK: Value - preview
    @IBOutlet var preview: UIView!
    @IBOutlet var previewTextView: UITextView!
    @IBOutlet var subContentTableView: UITableView!
    //MARK: Value - invite
    @IBOutlet var emailText: UITextField!
    @IBOutlet var fillTextField: UITextField!
    
    @IBOutlet var switchEditer: UISwitch!
    @IBOutlet var switchViewer: UISwitch!
    @IBOutlet var invitedView: UIView!
    var isRequesting: Bool = false
    var startDate: String = ""
    var endDate: String = ""
    var subContentController: SubContentController!
    var meetingId: Int = 0
    let manager = SocketManager(socketURL: URL(string: FDefined.SocketUrl)!, config: [.log(true)])
    
    var keyTime = "12/12/2018"
    var keyTitle = ""
    let keyAddress = "A17 Ta Quang Buu"
    let keyTptd = ["Nguyen Van An", "Tran Thu Ha", "Ha Van Thon"]
    var keyBoss = "Ta Minh Tuan"
    let keyAssistant = "Tran Van Sang"
    let keyContent = ["afdsafadsf", "sdfsdfdsfdsf","sdfdsfdsfd"]
    
    @IBOutlet var moreView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillTextField.delegate = self
        self.moreView.isHidden = true
        self.moreView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBackgroundWhenClickMore)))
        
        fillTextField.addTarget(self, action: #selector(touchToTextField), for: .touchDown)
        self.navigationController?.isNavigationBarHidden = true
        subContentController = ControllerFactory.createController(type: SubContentController.self, for: self) as? SubContentController
        initComponent()
        configureSocketIO()
        // Do any additional setup after loading the view.
    }
    
    func configureSocketIO() {
        
        SocketIOManager.sharedInstance.socketIOClient = manager.defaultSocket
        
        SocketIOManager.sharedInstance.socketIOClient.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("edit_subcontent") {data, ack in
            if !self.isRequesting {
                self.isRequesting = true
                UtilManage.showAlert(message: "Records were updated", type: .ok, complete: { (alert, button) in
                    self.subContentController.getMeeting(meetingId: self.meetingId)
                })
            }
            
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("delete_subcontent") {data, ack in
            if !self.isRequesting {
                self.isRequesting = true
                UtilManage.showAlert(message: "Records were updated", type: .ok, complete: { (alert, button) in
                    self.subContentController.getMeeting(meetingId: self.meetingId)
                })
            }
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("add_subcontent") { (data, ack) in
            if !self.isRequesting {
                self.isRequesting = true
                UtilManage.showAlert(message: "Records were updated", type: .ok, complete: { (alert, button) in
                    self.subContentController.getMeeting(meetingId: self.meetingId)
                })
            }
        }
        
        SocketIOManager.sharedInstance.socketIOClient.on("update_subcontent") { (data, ack) in
            if !self.isRequesting {
                self.isRequesting = true
                UtilManage.showAlert(message: "Records were updated", type: .ok, complete: { (alert, button) in
                    self.subContentController.getMeeting(meetingId: self.meetingId)
                })
            }
        }
        
        
    }
    
    @IBAction func exportPDFAction(_ sender: Any) {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        textView.text = self.generatorPDF()
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        // outputs as Data
        do {
            let data = try PDFGenerator.generated(by: [textView])
            try data.write(to: dst, options: .atomic)
            openPDFViewer(dst)
        } catch (let error) {
            print(error)
        }
    }
    
    
    func formatSubModelToText(model: SubContentModel) -> String {
        return "\(model.author) speaked \(model.content) from \(self.convertDate(date: model.startTime)) to \(self.convertDate(date: model.endTime))"
    }
    
    func generatorPDF() -> String {
        let content = Util.readTextFile(name: "template", type: "txt")
        let ct = self.subContentController.contents.map {formatSubModelToText(model: $0)}.reduce("") { $0 + "\n" + $1}
        let authors = Array(Set(self.subContentController.contents.map { $0.author}))
        let tptd = authors.reduce("") {$0 + "\n" + $1 }
        let result = content.replacingOccurrences(of: "key_time", with: self.keyTime).replacingOccurrences(of: "key_address", with: keyAddress).replacingOccurrences(of: "key_boss", with: keyBoss).replacingOccurrences(of: "key_assistant", with: keyAssistant).replacingOccurrences(of: "key_tptd", with: tptd).replacingOccurrences(of: "key_content", with: ct).replacingOccurrences(of: "key_title", with: keyTitle)
        return result
    }
    
    func openPDFViewer(_ pdfPath: URL) {
//        let url = URL(fileURLWithPath: pdfPath)
        let vc = PDFPreViewVC()
        vc.setupWithURL(pdfPath)
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.subContentController.getMeeting(meetingId: meetingId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let meeting = self.initData["meetingInfo"] as? MeetingModel {
            self.titleLabel.text = meeting.title
            self.meetingId = meeting.meetingId
            self.keyTime = meeting.createdAt
            self.keyTitle = meeting.title
            self.keyBoss = meeting.userName
        }
        SocketIOManager.sharedInstance.socketIOClient.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initComponent() {
        initTableView()
        registerCell()
        initTextView()
        initInvited()
    }
    
    func registerCell() {
        SubContentCell.registerCellByNib(subContentTableView)
    }
    
    func initTableView() {
        self.subContentTableView.delegate = self
        self.subContentTableView.dataSource = self
        self.subContentTableView.showsVerticalScrollIndicator = false
        
    }
    
    func initTextView() {
        self.previewTextView.delegate = self
        self.preview.isHidden = true
    }
    
    func initInvited() {
        self.invitedView.isHidden = true
        self.emailText.delegate = self
    }
    
    override func update(_ command: Command, data: Any?) {
        switch command {
        case .SubContent_gotData:
                self.subContentTableView.reloadData()
                self.preview.isHidden = true
                self.isRequesting = false
            break
        case .SubContent_invited:
            self.invitedView.isHidden = true
            UtilManage.alert(message: "Invited User", type: .ok, complete: nil)
        default:
            super.update(command, data: data)
        }
    }
    
    func getAuthorAndContentIsConfligFrom(startTime: String, endTime: String) -> ([String],[String], [SubContentModel]) {
        return (self.subContentController.fullContents.filter { $0.startTime == startTime && $0.endTime == endTime }.filter {$0.author != "" && $0.isFull == 0}.map { $0.author }, self.subContentController.fullContents.filter { $0.startTime == startTime && $0.endTime == endTime }.filter {$0.content != "" && $0.isFull == 0}.map { $0.content }, self.subContentController.fullContents.filter { $0.startTime == startTime && $0.endTime == endTime && $0.isFull == 0 })
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        if let user = StorageFactory.userStorage.getAll()?.first {
            SocketIOManager.sharedInstance.socketIOClient.emit("edit_subcontent", ["user_id": user.userId, "meeting_id": self.meetingId, "subcontent": ["id": 0, "author": user.name, "content": self.fillTextField.text ?? "", "start_time": self.startDate, "end_time": self.endDate]])
            self.fillTextField.text = ""
            self.fillTextField.resignFirstResponder()
        }
        
    }
    
    @IBAction func moreAction(_ sender: Any) {
        if self.moreView.isHidden {
            self.moreView.isHidden = false
        } else {
            self.moreView.isHidden = true
        }
    }
    
    @objc func tapBackgroundWhenClickMore() {
        self.moreView.isHidden = true
    }
    
    @IBAction func importAction(_ sender: Any) {
        self.moreView.isHidden = true
        let importVC = ImportViewController()
        importVC.meetingId = self.meetingId
        self.navigationController?.pushViewController(importVC, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.moreView.isHidden = true
        self.preview.isHidden = true
    }
    
    @IBAction func handleInviteAction(_ sender: Any) {
        self.moreView.isHidden = true
        self.invitedView.isHidden = false
    }
    
    @IBAction func showHistoryAction(_ sender: Any) {
        self.moreView.isHidden = true
        self.pushViewController(HistoryViewController.self, data: ["meetingId": meetingId])
    }
    
    @IBAction func handleBackAction(_ sender: Any) {
        SocketIOManager.sharedInstance.socketIOClient.disconnect()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleOkInvite(_ sender: Any) {
        if !switchViewer.isOn && !switchEditer.isOn || emailText.text == "" {
            return
        }
        
        if switchEditer.isOn {
            subContentController.inviteUser(email: emailText.text!, role: 1, meetingId: self.meetingId)
        } else {
            subContentController.inviteUser(email: emailText.text!, role: 0, meetingId: self.meetingId)
        }
        
    }
    @IBAction func handleCancelInvite(_ sender: Any) {
        self.invitedView.isHidden = true
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

extension SubContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subContentController.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SubContentCell.loadCell(tableView) as! SubContentCell
        cell.subContent = self.subContentController.contents[indexPath.row]
        cell.updatedText = { [weak self] text in
            guard let this = self else { return }
            let subcontent = this.subContentController.contents[indexPath.row]
            SocketIOManager.sharedInstance.socketIOClient.emit("edit_subcontent", ["user_id": subcontent.userId, "meeting_id": subcontent.meetingId, "subcontent": ["id": subcontent.subId, "author": subcontent.author, "content": text, "start_time": subcontent.startTime, "end_time": subcontent.endTime]])
//            (this.subContentController.contents[indexPath.row]).content = text
//            this.subContentController.updateText(meetingId: this.meetingId, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subContent = self.subContentController.contents[indexPath.row]
        guard subContent.flag == 1 else {
            return
        }
        
        let (authors, contents, subcontents) = self.getAuthorAndContentIsConfligFrom(startTime: subContent.startTime, endTime: subContent.endTime)
        
        let resolveViewController = ResolveConfligViewController()
        resolveViewController.subContentInfos = subcontents
        resolveViewController.subContentInfo = subContent
        resolveViewController.authors = authors
        resolveViewController.contents = contents
        self.navigationController?.pushViewController(resolveViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            let subContent = self.subContentController.contents[indexPath.row]
            SocketIOManager.sharedInstance.socketIOClient.emit("delete_subcontent", ["user_id": subContent.userId, "meeting_id": subContent.meetingId, "subcontent": ["id": subContent.subId, "author": subContent.author, "content": subContent.content, "start_time": subContent.startTime, "end_time": subContent.endTime]])
        }
    }
    
    func convertDate(date: String) -> String {
        guard date != "" else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var someDate = dateFormatter.date(from: date)
        if someDate == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssZ"
            someDate = dateFormatter.date(from: date)
        }
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm:ss"
        let strDay = dateFormatter2.string(from: someDate!)
        let dateInfo = "\(strDay)"
        
        return dateInfo
    }
    
    @objc func touchToTextField( textField: UITextField) {
        startDate = self.getCurrentDate()
    }
    
    
}

extension SubContentViewController: UITextViewDelegate {
    
}

extension SubContentViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        endDate = self.getCurrentDate()
    }
}
