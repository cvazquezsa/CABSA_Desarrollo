[Forma]
Clave=POSCteExpressNuevo
Nombre=Agregar Cliente Nuevo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=559
PosicionInicialArriba=81
PosicionInicialAltura=393
PosicionInicialAncho=482
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=668

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=$00804000
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 8, Blanco, []}
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=4
FichaEspacioNombres=81
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
ListaEnCaptura=(Lista)
PermiteEditar=S


ConFuenteEspecial=S
BarraBotones=S
BarraBtnFuente={Segoe UI, 8, Blanco, []}
BarraBtnFondo=$00804000
ListaAccionesBB=(Lista)
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
[(Variables).CteX.Nombre]
Carpeta=(Variables)
Clave=CteX.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.RFC]
Carpeta=(Variables)
Clave=CteX.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


AccionAlEnter=ValidarRFC
ColorFuente=Rojo obscuro
[(Variables).CteX.Direccion]
Carpeta=(Variables)
Clave=CteX.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=46
EspacioPrevio=S
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Poblacion]
Carpeta=(Variables)
Clave=CteX.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.CP]
Carpeta=(Variables)
Clave=CteX.CP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Pais]
Carpeta=(Variables)
Clave=CteX.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Estado]
Carpeta=(Variables)
Clave=CteX.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Colonia]
Carpeta=(Variables)
Clave=CteX.Colonia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[Acciones.Guardar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Guardar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S

Expresion=Asigna(Info.Mensaje,SQL(<T>SELECT dbo.fnPOSValidarCteExpress(:tRFC)<T>,CteX.RFC) )<BR><BR>SI<BR>Info.Mensaje = 1<BR>Entonces<BR>Informacion(<T>El R.F.C. Esta Duplicado<T>)<BR>SiNo<BR>Asigna(Info.Cliente, SQL(<T>EXEC spPOSAgregarClienteExpress :nSucursal, :tCliente, :tNombre, :tDireccion, :tDireccionNum, :tDireccionNumInt, :tEntreCalles, :tDelegacion, :tColonia, :tPoblacion, :tEstado, :tPais, :tCodigoPostal, :tRFC, :tCURP, :tCon, :tEmail, :nNuevo, :tZonaImp<T>,<BR>    Sucursal, Info.Cliente, CteX.Nombre,  CteX.Direccion, CteX.DireccionNumero, CteX.DireccionNumeroInt, CteX.EntreCalles, CteX.Delegacion, CteX.Colonia, CteX.Poblacion,  CteX.Estado, CteX.Pais, CteX.CP, CteX.RFC, CteX.CURP, CteX.Contacto, CteX.Email, 1, CteX.ZonaImpuesto))<BR><BR>Si Vacio(Info.Cliente) Entonces Error(<T>Falta configurar los consecutivos de cliente, o estos estan repetidos<T>)<BR>Sino Informacion(<T>Se dio de alta al cliente <T>+ Info.Cliente +<T>  exitosamente<T>)<BR>Fin<BR>Fin
EjecucionCondicion=ConDatos(CteX.Nombre)
[Acciones.Guardar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
ConCondicion=S

EjecucionCondicion=ConDatos(CteX.Nombre) y ConDatos(Info.Cliente)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



[Acciones.Guardar]
Nombre=Guardar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

[Acciones.Buscar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Buscar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
ConCondicion=S
EjecucionCondicion=Forma(<T>CteExpressLista<T>)


[(Variables).CteX.Delegacion]
Carpeta=(Variables)
Clave=CteX.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








ColorFuente=Rojo obscuro
[(Variables).CteX.DireccionNumero]
Carpeta=(Variables)
Clave=CteX.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Blanco

ValidaNombre=S
OcultaNombre=S
ColorFuente=Rojo obscuro
[(Variables).CteX.DireccionNumeroInt]
Carpeta=(Variables)
Clave=CteX.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=7
ColorFondo=Blanco

ValidaNombre=S




OcultaNombre=S




ColorFuente=Rojo obscuro
[(Variables).CteX.CURP]
Carpeta=(Variables)
Clave=CteX.CURP
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.EntreCalles]
Carpeta=(Variables)
Clave=CteX.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



























ColorFuente=Rojo obscuro
[Acciones.ValidarRFC.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.ValidarRFC.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si SQL(<T>SELECT Count(Cliente) FROM Cte WHERE RFC = :tRFC AND RFC NOT IN(:t1,:t2)<T>, CteX.RFC,<T>XAXX010101000<T>, <T>XEXX010101000<T> ) >=1  Entonces  <BR>Precaucion(<T>El Cliente <T> + SQL(<T>SELECT CONVERT(varchar,Cliente) + SPACE(1) + Nombre FROM Cte WHERE RFC = :tRFC<T>,  CteX.RFC) + <T> tiene el mismo RFC<T>) Fin
[Acciones.ValidarRFC]
Nombre=ValidarRFC
Boton=0
NombreDesplegar=ValidarRFC
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S







[(Variables).CteX.eMail]
Carpeta=(Variables)
Clave=CteX.eMail
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco







ColorFuente=Rojo obscuro
[(Variables).CteX.Contacto]
Carpeta=(Variables)
Clave=CteX.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









ColorFuente=Rojo obscuro
[(Variables).CteX.FechaNacimiento]
Carpeta=(Variables)
Clave=CteX.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Sexo]
Carpeta=(Variables)
Clave=CteX.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro

[(Variables).CteX.EstadoCivil]
Carpeta=(Variables)
Clave=CteX.EstadoCivil
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
ColorFuente=Rojo obscuro
[(Variables).CteX.Religion]
Carpeta=(Variables)
Clave=CteX.Religion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Profesion]
Carpeta=(Variables)
Clave=CteX.Profesion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Conyuge]
Carpeta=(Variables)
Clave=CteX.Conyuge
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Puesto]
Carpeta=(Variables)
Clave=CteX.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.NumeroHijos]
Carpeta=(Variables)
Clave=CteX.NumeroHijos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



ColorFuente=Rojo obscuro
[(Variables).CteX.ZonaImpuesto]
Carpeta=(Variables)
Clave=CteX.ZonaImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco









ColorFuente=Rojo obscuro
[Acciones.ValidarRFC.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Expresion
Expresion=(Fin)



















[(Variables).CteX.Categoria]
Carpeta=(Variables)
Clave=CteX.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Grupo]
Carpeta=(Variables)
Clave=CteX.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

ColorFuente=Rojo obscuro
[(Variables).CteX.Familia]
Carpeta=(Variables)
Clave=CteX.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


ColorFuente=Rojo obscuro
[Lista.Columnas]
Familia=233


















[Acciones.Guarda]
Nombre=Guarda
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=Guardar.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



ListaAccionesMultiples=(Lista)


[Acciones.Guarda.AsignaVariables]
Nombre=AsignaVariables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Guarda.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Asigna(Info.Mensaje,SQL(<T>SELECT dbo.fnPOSValidarCteExpress(:tRFC)<T>,CteX.RFC) )<BR><BR>SI<BR>Info.Mensaje = 1<BR>Entonces<BR>Informacion(<T>El R.F.C. Esta Duplicado<T>)<BR>SiNo<BR>Asigna(Info.Cliente, SQL(<T>EXEC spPOSAgregarClienteExpress :nSucursal, :tCliente, :tNombre, :tDireccion, :tDireccionNum, :tDireccionNumInt, :tEntreCalles, :tDelegacion, :tColonia, :tPoblacion, :tEstado, :tPais, :tCodigoPostal, :tRFC, :tCURP, :tCon, :tEmail, :nNuevo, :tZonaImp, :t.FechaNacimiento, :tEstadoCivil, :tConyuge, :tSexo, :tProfesion, :tPuesto, :tNumeroHijos, :tReligion <T>,<BR>    Sucursal, Info.Cliente, CteX.Nombre,  CteX.Direccion, CteX.DireccionNumero, CteX.DireccionNumeroInt, CteX.EntreCalles, CteX.Delegacion, CteX.Colonia, CteX.Poblacion,  CteX.Estado, CteX.Pais, CteX.CP, CteX.RFC, CteX.CURP, CteX.Contacto, CteX.Email, 1, CteX.ZonaImpuesto,    CteX.FechaNacimiento, CteX.EstadoCivil , CteX.Conyuge ,  CteX.Sexo,  CteX.Profesion,  CteX.Puesto,  CteX.NumeroHijos,  CteX.Religion))<BR><BR>Si Vacio(Info.Cliente) Entonces Error(<T>Falta configurar los consecutivos de cliente, o estos estan repetidos<T>)<BR>Sino Informacion(<T>Se dio de alta al cliente <T>+ Info.Cliente +<T>  exitosamente<T>)<BR>Fin<BR>Fin
[Acciones.Guarda.Cierra]
Nombre=Cierra
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteX.Nombre) y ConDatos(Info.Cliente)
Visible=S


[Acciones.Cancela]
Nombre=Cancela
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
BarraBtnAncho=75
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=45
BarraBtnImgAlto=45
NombreEnBotonX=S
edBotonSrc=CancelarPartida.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado



[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=SQL
SQL=Cerrar
Cerrar=(Fin)




[Acciones.Separador1]
Nombre=Separador1
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=75
BarraBtnFondo=Plata
BarraBtnPagina=1






[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=ValidarRFC
ValidarRFC=(Fin)







[Acciones.Guarda.ListaAccionesMultiples]
(Inicio)=AsignaVariables
AsignaVariables=SQL
SQL=Cierra
Cierra=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=CteX.Nombre
CteX.Nombre=CteX.RFC
CteX.RFC=CteX.CURP
CteX.CURP=CteX.Categoria
CteX.Categoria=CteX.Grupo
CteX.Grupo=CteX.Familia
CteX.Familia=CteX.Direccion
CteX.Direccion=CteX.DireccionNumero
CteX.DireccionNumero=CteX.DireccionNumeroInt
CteX.DireccionNumeroInt=CteX.EntreCalles
CteX.EntreCalles=CteX.CP
CteX.CP=CteX.Delegacion
CteX.Delegacion=CteX.Colonia
CteX.Colonia=CteX.Poblacion
CteX.Poblacion=CteX.Estado
CteX.Estado=CteX.Pais
CteX.Pais=CteX.Contacto
CteX.Contacto=CteX.eMail
CteX.eMail=CteX.ZonaImpuesto
CteX.ZonaImpuesto=CteX.FechaNacimiento
CteX.FechaNacimiento=CteX.Sexo
CteX.Sexo=CteX.EstadoCivil
CteX.EstadoCivil=CteX.Religion
CteX.Religion=CteX.Profesion
CteX.Profesion=CteX.Conyuge
CteX.Conyuge=CteX.Puesto
CteX.Puesto=CteX.NumeroHijos
CteX.NumeroHijos=(Fin)

[(Variables).ListaAccionesBB]
(Inicio)=Separador1
Separador1=Guarda
Guarda=Cancela
Cancela=(Fin)
