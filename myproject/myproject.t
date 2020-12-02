﻿Unit={
State={},
Param={}
}
H={}
function processState(stateTable,stateName,stateParam)
    if stateTable[stateName]~=nil then
        return stateTable[stateName](stateParam)
    end
    return "Error"
end
H["登录界面"]={
{"登录按钮",0.8,608,588,682,631,"144393-000000","-7|-2|C7CDD7-000000,-15|6|CECECF-000000,13|-1|144495-000000"},
{"公告",0.8,600,77,681,117,"1A2942-000000","-2|-12|080C13-000000,-5|-11|FFFFFF-000000,6|-9|FFFFFF-000000"},
{"进入游戏",0.8,542,485,656,549,"FFFDF5-000000","-2|8|FDF6D6-000000,30|25|F98C41-000000,25|2|F75520-000000,40|14|FB7440-000000"},
{"进入游戏1",0.8,623,652,664,681,"9A2818-000000","0|10|9C3822-000000,0|14|EEDD99-000000,8|14|F3D298-000000"}
}
function waitFound(timeout,bt,click)
    XM.TimerInit(9999)    
    for i=0,timeout*5,1 do
        XM.Print("等待图色"..bt)
        XM.KeepScreen()
        if XM.Timer(9999) then
            if XM.Find(5,bt,click) then
                XM.Print("点击图色")
                return true              
            end
        else
            --            XM.Print(tostring(i))
            sleep(200)
        end
    end
    return false
end
function afterLogin()
    XM.Print("等待公告")
    XM.SetTableID("登录界面")
    XM.Print("开始寻找登录按钮")
    if waitFound(120,"公告",false)~=true then
        return "ERROR"
    end
    XM.Print("公告页面")
    if waitFound(120,"登录按钮",true)~=true then
        return "ERROR"
    end
    XM.Print("进入游戏页面")
    if waitFound(60,"进入游戏",true)~=true then
        return "ERROR"
    end
    XM.Print("角色选择页面")
    if waitFound(60,"进入游戏1",true)~=true then
        return "ERROR"
    end
    XM.Print("回城")
    
    
end
function choseGamer(idx)
    for i=0,2,1 do
        XM.RndTap(100,346)
        sleep(1000)
    end
    local page,other=math.modf(idx/8)
    for i=0,page-1,1 do
        XM.RndTap(1184,355)
        sleep(1000)
    end
    idx=idx %8
    local row,other1=math.modf(idx/4)
    local col=idx%4
    local x=276+225*col
    local y=292+219*row
    XM.RndTap(x,y)
    sleep(1000)
    
end
function goChoseGamer()
    XM.RndTap(32,54)
    sleep(1000)
    XM.RndTap(863,604)
    sleep(1000)
    -- 等待页面稳定
    
end

function floatwinrun()
    -- 浮动窗口运行按钮执行的事件,如果不需要可去掉
    messagebox("脚本开始运行")
    require("XM")
    logopen()
    XM.AddTable(H)
    
    setrotatescreen(1)
    --    main()
    goChoseGamer()
    choseGamer(0)
    choseGamer(4)
    choseGamer(7)
    choseGamer(8)
    
    --    local x=-1 y=-1 ret=-1
    --x,y,ret=findmulticolor(542,485,656,549,"FFFDF5-000000","-2|8|FDF6D6-000000,30|25|F98C41-000000,25|2|F75520-000000,40|14|FB7440-000000",0.8,0)
    --if x~=-1 then
    --tap(x,y)
    --end
    
    --    keepcapture(0) 
    --    local ret = screencap(0,0,500,500,"/sdcard/t.bmp")
    --    if ret == true then
    --        messagebox("截图成功")
    --    else
    --        messagebox("截图失败")
    --    end
    --    tap(633,609)
    --    sleep(100)
    
    
    
end
function main()
    
    Unit.State.Name="init"
    while true do
        Unit.State.Name=processState(Unit.State,Unit.State.Name,Unit.Param[Unit.State.Name])
        XM.Print("当前状态:"..Unit.State.Name)
        sleep(200)
    end
    
end
PACKAGES={"com.hegu.dnl.mi","com.hegu.dnl.sn79"}
-- appType类型
APP_XM=1 -- 小米
APP_SS=2 -- 上士
function startApp(appType)
    if appType==APP_XM then
        messagebox("启动小米版")
        local ret = cmd("su root am start -n com.hegu.dnl.mi/com.hegu.dnl.MainActivity") 
        return ret~=nil
    else
        local package=PACKAGES[appType]
        local ret=sysstartapp(package)
        return ret==1
    end
    
    
    return ret==1
    
end
function isRuning(appType)
    local ret=sysisrunning(PACKAGES[appType])
    return ret==1
end 
Unit.Param.init={

}


function Unit.State.init(initParam)
    initParam.appType=APP_XM 
    Unit.Param.login.appType=APP_XM
    return "login"
end
Unit.Param.login={
}
function Unit.State.login(userInfo)
    if startApp(userInfo.appType)   then
        afterLogin()
        return "choseUser"
    end
    
    return "Error"
    
    
end
Unit.Param.choseUser={}
function Unit.State.choseUser(choseUser)
    return "choseUser"
end