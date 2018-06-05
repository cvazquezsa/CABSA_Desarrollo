[Forma]
Clave=RepWMSAuxU
Nombre=Existencia por producto y Tarima a una fecha de corte
Icono=18
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
AccionesTamanoBoton=25x5
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
PosicionInicialIzquierda=572
PosicionInicialArriba=289
PosicionInicialAltura=550
PosicionInicialAncho=456
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
MovModulo=Inv
MovEspecificos=Todos
PosicionInicialAlturaCliente=283


VentanaEstadoInicial=Normal
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spBorrarRepWMSPorCorte :nEstacionTrabajo<T>,  EstacionTrabajo)
[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
EspacioPrevio=N
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

Antes=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.EstacionTrabajo, RepParam:RepParam.Estacion)<BR>Asigna(Rep.Titulo, RepParam:RepParam.RepTitulo)<BR>Asigna(Rep.InvVal, RepParam:RepParam.InfoValuacion)
[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

Antes=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.EstacionTrabajo, RepParam:RepParam.Estacion)<BR>Asigna(Rep.Titulo, RepParam:RepParam.RepTitulo)<BR>Asigna(Rep.InvVal, RepParam:RepParam.InfoValuacion)
[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

GuardarAntes=S
[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.Aux]
Carpeta=(Variables)
Clave=Rep.Aux
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=N

[(Variables).Info.ArtCat]
Carpeta=(Variables)
Clave=Info.ArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.ArtFam]
Carpeta=(Variables)
Clave=Info.ArtFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArtGrupo]
Carpeta=(Variables)
Clave=Info.ArtGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Fabricante]
Carpeta=(Variables)
Clave=Info.Fabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.InvAcumU]
Carpeta=(Variables)
Clave=Rep.InvAcumU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Rep.InvVal]
Carpeta=(Variables)
Clave=Rep.InvVal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.SubCuenta]
Carpeta=(Variables)
Clave=Info.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ArtLinea]
Carpeta=(Variables)
Clave=Info.ArtLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.InvAuxUMov]
Carpeta=(Variables)
Clave=Rep.InvAuxUMov
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.SubCuenta
Info.SubCuenta=Info.ArtCat
Info.ArtCat=Info.ArtFam
Info.ArtFam=Info.ArtGrupo
Info.ArtGrupo=Info.Fabricante
Info.Fabricante=Info.ArtLinea
Info.ArtLinea=Rep.InvAcumU
Rep.InvAcumU=Rep.InvAuxUMov
Rep.InvAuxUMov=Rep.InvVal
Rep.InvVal=Info.Moneda
Info.Moneda=Rep.Aux
Rep.Aux=Info.Almacen
Info.Almacen=Rep.Titulo
Rep.Titulo=(Fin)





[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion =  {EstacionTrabajo}
[Ficha.RepParam.InfoFechaD]
Carpeta=Ficha
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoFechaA]
Carpeta=Ficha
Clave=RepParam.InfoFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArticuloD]
Carpeta=Ficha
Clave=RepParam.InfoArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.RepParam.InfoArticuloA]
Carpeta=Ficha
Clave=RepParam.InfoArticuloA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtCat]
Carpeta=Ficha
Clave=RepParam.InfoArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.RepParam.InfoArtFam]
Carpeta=Ficha
Clave=RepParam.InfoArtFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtGrupo]
Carpeta=Ficha
Clave=RepParam.InfoArtGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtFabricante]
Carpeta=Ficha
Clave=RepParam.InfoArtFabricante
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoArtLinea]
Carpeta=Ficha
Clave=RepParam.InfoArtLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoAlmacenWMS]
Carpeta=Ficha
Clave=RepParam.InfoAlmacenWMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.RepTitulo]
Carpeta=Ficha
Clave=RepParam.RepTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



















EspacioPrevio=S
[Ficha.RepParam.InfoMovimientoEsp]
Carpeta=Ficha
Clave=RepParam.InfoMovimientoEsp
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
EspacioPrevio=S
[Ficha.RepParam.InfoNivel]
Carpeta=Ficha
Clave=RepParam.InfoNivel
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[Acciones.Imprimir.WMSAuxU]
Nombre=WMSAuxU
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Info.EstacionTrabajo, EstacionTrabajo)<BR>Caso RepParam:RepParam.InfoNivel<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>WMSAuxU<T>, RepParam:RepParam.InfoArticuloD, RepParam:RepParam.InfoArticuloA, RepParam:RepParam.InfoFechaD, RepParam:RepParam.InfoFechaA)<BR>  Es <T>Desglosado por día<T> Entonces ReportePantalla(<T>WMSAuxUDia<T>, RepParam:RepParam.InfoArticuloD, RepParam:RepParam.InfoArticuloA, RepParam:RepParam.InfoFechaD, RepParam:RepParam.InfoFechaA)<BR>Fin
[Acciones.RepPan.WMSAuxU]
Nombre=WMSAuxU
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Caso RepParam:RepParam.InfoNivel<BR>  Es <T>Desglosado<T> Entonces ReportePantalla(<T>WMSAuxU<T>, RepParam:RepParam.InfoArticuloD, RepParam:RepParam.InfoArticuloA, RepParam:RepParam.InfoFechaD, RepParam:RepParam.InfoFechaA)<BR>  Es <T>Desglosado por día<T> Entonces ReportePantalla(<T>WMSAuxUDia<T>, RepParam:RepParam.InfoArticuloD, RepParam:RepParam.InfoArticuloA, RepParam:RepParam.InfoFechaD, RepParam:RepParam.InfoFechaA)<BR>Fin
[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=(Variables)
(Variables)=(Fin)










[Ficha.RepParam.InfoValuacion]
Carpeta=Ficha
Clave=RepParam.InfoValuacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







































[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoArticuloD
RepParam.InfoArticuloD=RepParam.InfoArticuloA
RepParam.InfoArticuloA=RepParam.InfoArtCat
RepParam.InfoArtCat=RepParam.InfoArtFam
RepParam.InfoArtFam=RepParam.InfoArtGrupo
RepParam.InfoArtGrupo=RepParam.InfoArtFabricante
RepParam.InfoArtFabricante=RepParam.InfoArtLinea
RepParam.InfoArtLinea=RepParam.InfoMovimientoEsp
RepParam.InfoMovimientoEsp=RepParam.InfoNivel
RepParam.InfoNivel=RepParam.InfoAlmacenWMS
RepParam.InfoAlmacenWMS=RepParam.InfoValuacion
RepParam.InfoValuacion=RepParam.RepTitulo
RepParam.RepTitulo=(Fin)














[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=WMSAuxU
WMSAuxU=(Fin)


[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=WMSAuxU
WMSAuxU=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
