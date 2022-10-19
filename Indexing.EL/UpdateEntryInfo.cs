using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class UpdateEntryInfo
{
    public bool Success { get; set; }

    public Guid? Id { get; set; }

    public string Exception { get; set; }

    public int? IdNumeric { get; set; }

    public UpdateEntryInfo() { }

    public UpdateEntryInfo(Guid? id, bool success, string exception)
    {
        this.Id = id;
        this.Success = success;
        this.Exception = exception;
    }
}

