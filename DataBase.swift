//
//  DataBase.swift
//  Sql_music
//
//  Created by Pham Ngoc Hai on 1/11/17.
//  Copyright © 2017 pnh. All rights reserved.
//

import Foundation
class DataBase{
    static let shareIntance = DataBase()
    var dataBasePath = NSString()
    
    
    init() {
        getPath()
        creatDataBase()
        insertDataBase(nameTable: "ALBUMS", ditc: ["Price":"200.000", "AlbumName":"Anh Bỏ Thuốc Em Sẽ Yêu", "ReleaseDate":"11/1/2015", "UrlImg":"Anh Bỏ Thuóc Em Sẽ yêu - Lyna Thuỳ Linh.jpg"])
        print(viewDataBase(TableName: "ALBUMS", columns: ["*"], statement: ""))
    }
    func getPath() {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = NSString(string: dirPaths[0])
        dataBasePath = docsDir.appendingPathComponent("musics.db") as NSString
    }
    func creatDataBase() -> Bool{
        let file = FileManager.default
        if !file.fileExists(atPath: dataBasePath as String)
        {
            let musicsDB = FMDatabase(path: dataBasePath as String)
            if musicsDB == nil
            {
                print("Error: \(musicsDB?.lastErrorMessage())")
            }
            if (musicsDB?.open())!
            {
                let sql_Create_SONGS = "create table if not exists SONGS (ID integer primary key autoincrement, SongName text, UrlImg text)"
                
                let sql_Create_DetailPlayList = "create table if not exists DetailPlayList (SongID integer, PlayListID integer, foreign key (SongID) references SONGS(ID), foreign key (PlayListID) references PLAYLIST(ID), primary key (SongID, PlayListID))"
                
                let sql_Create_PlayList = "create table if not exists PLAYLIST (ID integer primary key autoincrement, PlaylistName text)"
                
                let sql_Create_ALBUMS = "create table if not exists ALBUMS (ID integer primary key autoincrement, Price text, AlbumName text, ReleaseDate text, UrlImg text)"
                
                let sql_Create_DetailAlbum = "create table if not exists DETAILALBUM (AlbumID integer, GenreID integer, ArtistID integer, SongID integer, foreign key (AlbumID) references ALBUMS(ID), foreign key (GenreID) references GENRES(ID), foreign key (ArtistID) references ARTISTS(ID), foreign key (SongID) references SONGS(ID), primary key (AlbumID, GenreID, ArtistID, SongID))"
                
                let sql_Create_ARTISTS = "create table if not exists ARTISTS (ID integer primary key autoincrement, ArtistName text, UrlImg text, Born text not null)"
                
                let sql_Create_GENRES = "create table if not exists GENRES (ID integer primary key autoincrement, GenreName text)"
                if (!(musicsDB?.executeStatements(sql_Create_SONGS))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                if (!(musicsDB?.executeStatements(sql_Create_ALBUMS))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                if (!(musicsDB?.executeStatements(sql_Create_GENRES))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                if (!(musicsDB?.executeStatements(sql_Create_ARTISTS))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                if (!(musicsDB?.executeStatements(sql_Create_PlayList))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                if (!(musicsDB?.executeStatements(sql_Create_DetailAlbum))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                if (!(musicsDB?.executeStatements(sql_Create_DetailPlayList))!)
                {
                    print("Error: \(musicsDB?.lastErrorMessage())")
                }
                
            }
            else{
                print("Error: \(musicsDB?.lastErrorMessage())")
                
            }
            musicsDB?.close()
            return true
            
            
        }
        return false
    }
    
    func insertDataBase (nameTable: String, ditc: NSDictionary)
    {
        var keys = String()
        var values = String()
        var first = true
        for key in ditc.allKeys
        {
            if (first == true)
            {
                keys = "'" + (key as! String) + "'"
                values = "'" + (ditc.object(forKey: key) as! String) + "'"
                first = false
                continue
            }
            keys = keys + "," + "'" + (key as! String) + "'"
            values = values + "," + "'" + (ditc.object(forKey: key) as! String) + "'"
        }
        let musicsDB = FMDatabase(path: dataBasePath as String)
        if musicsDB == nil
        {
            print("Error: \(musicsDB?.lastErrorMessage())")
        }
        if (musicsDB?.open())!
        {
            if !(musicsDB?.executeStatements("PRAGMA foreign_keys = ON"))! {
                print("ERROR: \(musicsDB?.lastErrorMessage())")
            }
            let insertSQL = "INSERT INTO \(nameTable) (\(keys)) VALUES (\(values))"
            let result = musicsDB?.executeUpdate(insertSQL, withArgumentsIn: nil)
            if !result! {
                print("ERROR: \(musicsDB?.lastErrorMessage())")
                
            }
        }
    }
    func viewDataBase(TableName: String, columns: [String], statement: String) -> [NSDictionary] {
        var allColumns = ""
        var items = [NSDictionary]()
        for column in columns
        {
            if (allColumns == "")
            {
                allColumns = column
            }
            else
            {
                allColumns = allColumns + "," + column
            }
        }
        let querySQL = "Select DISTINCT \(allColumns) From \(TableName) \(statement)"
        let musicsDB = FMDatabase(path: dataBasePath as String)
        if (musicsDB?.open())! {
            let results:FMResultSet? = musicsDB?.executeQuery(querySQL,
                                                               withArgumentsIn: nil)
            while ((results?.next()) == true)
            {
                items.append(results!.resultDictionary() as NSDictionary)
            }
        }
        musicsDB?.close()
        return items
    }
    
}
