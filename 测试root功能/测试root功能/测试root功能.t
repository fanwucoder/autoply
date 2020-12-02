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
{"登录按钮",0.8,725,645,775,698,"101A28-111111","7|7|101A28-111111,6|19|101A28-111111"},
{"公告",0.8,596,70,688,126,"FFFFFF-000000","4|0|141F33-000000,6|0|737477-000000,9|0|19273F-000000"},
{"进入游戏",0.8,554,494,603,553,"FBF1C4-000000","5|0|BB4411-000000,15|6|DA5E2E-000000,61|-427|19273F-000000"}
}
function floatwinrun()
    -- 浮动窗口运行按钮执行的事件,如果不需要可去掉
    messagebox("脚本开始运行")
    require("XM")
    XM.AddTable(H)
    setrotatescreen(1)
    
    
    
    --    local ret = screencap(0,0,500,500,"/sdcard/t.bmp")
    --if ret == true then
    --messagebox("截图成功")
    --else
    --messagebox("截图失败")
    --end
    
    
    XM.SetTableID("登录界面")
    messagebox("点击登录按钮")
    while true do
        XM.KeepScreen()
        if XM.Find(5,"公告") then
            if XM.Find(5,"登录按钮",true) then
                messagebox("找到登录了")   
                break
            end
        end
        sleep(1000)
        messagebox("暂未找到公告")
    end
    
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
        return "choseUser"
    end
    
    return "Error"
    
    
end
Unit.Param.choseUser={}
function Unit.State.choseUser(choseUser)
    return "choseUser"
end