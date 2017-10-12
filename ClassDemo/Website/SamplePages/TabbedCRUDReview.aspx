﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TabbedCRUDReview.aspx.cs" Inherits="SamplePages_TabbedCRUDReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
      <div class="row jumbotron">
        <h1>Tabbed CRUD REview</h1>
    </div>
     <div class="row">
        <div class="col-md-12">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#search" data-toggle="tab">Lookup</a></li>
                <li><a href="#crud" data-toggle="tab">Add Update Delete</a></li>
                <li><a href="#listviewcrud" data-toggle="tab">ListView Crud</a></li>
            </ul>
            <!-- tab content area -->
            <div class="tab-content">
                <!-- user tab -->
                <div class="tab-pane fade in active" id="search">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                           Enter Album Name:
                            <asp:TextBox ID="SearchArgAlbum" runat="server"></asp:TextBox>
                            <asp:Button ID="Fetch" runat="server" Text="Fetch" /><br />
                            <asp:GridView ID="SearchResults" runat="server" 
                                AutoGenerateColumns="False" DataSourceID="SearchResultsODS" 
                                AllowPaging="True" GridLines="None" 
                                OnSelectedIndexChanged="SearchResults_SelectedIndexChanged"
                                OnPageIndexChanging="SearchResults_PageIndexChanging" >
                                <Columns>
                                    <asp:TemplateField >
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("AlbumId") %>' 
                                                ID="AlbumID" Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                                    <asp:TemplateField >
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server"
                                                ID="ArtistList" 
                                                DataSourceID="ArtistListODS" 
                                                DataTextField="Name" 
                                                DataValueField="ArtistId"
                                                SelectedValue='<%# Bind("ArtistID") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ReleaseYear" HeaderText="ReleaseYear" SortExpression="ReleaseYear"></asp:BoundField>
                                    <asp:BoundField DataField="ReleaseLabel" HeaderText="ReleaseLabel" SortExpression="ReleaseLabel"></asp:BoundField>
                                    <asp:CommandField SelectText="View" ShowSelectButton="True"></asp:CommandField>

                                </Columns>
                                <SelectedRowStyle BackColor="#99CCFF" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="SearchResultsODS" runat="server" 
                                OldValuesParameterFormatString="original_{0}" 
                                SelectMethod="Albums_ListByTitle" 
                                TypeName="ChinookSystem.BLL.AlbumController">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="SearchArgAlbum" 
                                        PropertyName="Text" DefaultValue="zxzx" Name="title" 
                                        Type="String"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                
                </div> <%--eop--%>
                <!-- role tab -->
                <div class="tab-pane fade" id="crud">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Message" runat="server" ></asp:Label>
                           <table>
                               <tr>
                                   <td>Album ID:</td>
                                   <td>
                                       <asp:Label ID="AlbumID" runat="server" ></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Title:</td>
                                   <td>
                                       <asp:TextBox ID="AlbumTitle" runat="server" ></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Artist:</td>
                                   <td>
                                       <asp:DropDownList ID="ArtistList" runat="server" 
                                           DataSourceID="ArtistListODS" 
                                           DataTextField="Name" 
                                           DataValueField="ArtistId"></asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Release Year:</td>
                                   <td>
                                       <asp:TextBox ID="ReleaseYear" runat="server" ></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <td>Release Label:</td>
                                   <td>
                                       <asp:TextBox ID="ReleaseLabel" runat="server" ></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <td colspan="2">
                                   <asp:Button ID="Add" runat="server" Text="Add" Width="100px" OnClick="Add_Click" />&nbsp;&nbsp;
                                   <asp:Button ID="Update" runat="server" Text="Update" Width="100px" OnClick="Update_Click"/>&nbsp;&nbsp;
                                   <asp:Button ID="Delete" runat="server" Text="Delete" Width="100px" OnClick="Delete_Click"/>&nbsp;&nbsp;
                                   <asp:Button ID="Clear" runat="server" Text="Clear" Width="100px" OnClick="Clear_Click"/>
                                   </td>
                               </tr>
                           </table>
                            <asp:ObjectDataSource ID="ArtistListODS" runat="server" 
                                OldValuesParameterFormatString="original_{0}" 
                                SelectMethod="Artists_List" 
                                TypeName="ChinookSystem.BLL.ArtistController"></asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div> <%--eop--%>
                <!-- unregistered user tab -->
                <div class="tab-pane fade" id="listviewcrud">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:ListView ID="ListViewCRUD" 
                                runat="server" 
                                DataSourceID="ListViewCRUDODS" 
                                InsertItemPosition="LastItem" 
                                DataKeyNames="AlbumId">

                                <AlternatingItemTemplate>
                                    <span style="background-color: #FAFAD2; color: #284775;">
                                        Title:
                                        <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /><br />
                                        ArtistId:
                                        <asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /><br />
                                        ReleaseYear:
                                        <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /><br />
                                        ReleaseLabel:
                                        <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /><br />
                                        <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                        <br />
                                        <br />
                                    </span>


                                </AlternatingItemTemplate>
                                <EditItemTemplate>
                                    <span style="background-color: #FFCC66; color: #000080;">
                                        Title:
                                        <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /><br />
                                        ArtistId:
                                        <asp:TextBox Text='<%# Bind("ArtistId") %>' runat="server" ID="ArtistIdTextBox" /><br />
                                        ReleaseYear:
                                        <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBox" /><br />
                                        ReleaseLabel:
                                        <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBox" /><br />
                                        <asp:TextBox Text='<%# Bind("Tracks") %>' runat="server" ID="TracksTextBox" /><br />
                                        <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" /><asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /><br />
                                        <br />
                                    </span>


                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <span>No data was returned.</span>

                                </EmptyDataTemplate>
                                <InsertItemTemplate>
                                    <span style="">
                                        Title:
                                        <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /><br />
                                        ArtistId:
                                        <asp:TextBox Text='<%# Bind("ArtistId") %>' runat="server" ID="ArtistIdTextBox" /><br />
                                        ReleaseYear:
                                        <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBox" /><br />
                                        ReleaseLabel:
                                        <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBox" /><br />
                                        <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
                                        <br />
                                    </span>


                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <span style="background-color: #FFFBD6; color: #333333;">
                                        Title:
                                        <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /><br />
                                        ArtistId:
                                        <asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /><br />
                                        ReleaseYear:
                                        <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /><br />
                                        ReleaseLabel:
                                        <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /><br />
                                        <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                        <br />
                                        <br />
                                    </span>


                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>
                                    <div style="text-align: center; background-color: #FFCC66; font-family: Verdana, Arial, Helvetica, sans-serif; color: #333333;">
                                        <asp:DataPager runat="server" ID="DataPager1">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                            </Fields>
                                        </asp:DataPager>

                                    </div>


                                </LayoutTemplate>
                                <SelectedItemTemplate>
                                    <span style="background-color: #FFCC66; font-weight: bold; color: #000080;">
                                        Title:
                                        <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /><br />
                                        ArtistId:
                                        <asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /><br />
                                        ReleaseYear:
                                        <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /><br />
                                        ReleaseLabel:
                                        <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /><br />
                                        <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                        <br />
                                        <br />
                                    </span>


                                </SelectedItemTemplate>
                            </asp:ListView>
                            <asp:ObjectDataSource ID="ListViewCRUDODS" runat="server" 
                                DataObjectTypeName="Chinook.Data.Entities.Album" 
                                DeleteMethod="Albums_Delete" 
                                InsertMethod="Albums_Add" 
                                OldValuesParameterFormatString="original_{0}"
                                 SelectMethod="Albums_List" 
                                TypeName="ChinookSystem.BLL.AlbumController" 
                                UpdateMethod="Albums_Update">

                            </asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div> <%--eop--%>
            </div>
        </div>

    </div>
</asp:Content>

