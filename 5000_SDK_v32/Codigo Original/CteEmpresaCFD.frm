[Forma]
Clave=CteEmpresaCFD
Nombre=Datos CFD del Cliente - Nivel Empresa
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=102
PosicionInicialArriba=266
PosicionInicialAlturaCliente=202
PosicionInicialAncho=819
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cliente, Info.Nombre)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEmpresaCFD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=CteEmpresaCFD.Cliente=<T>{Info.Cliente}<T>
[Lista.CteEmpresaCFD.Empresa]
Carpeta=Lista
Clave=CteEmpresaCFD.Empresa
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
Editar=S

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CteEmpresaCFD.EmisorID]
Carpeta=Lista
Clave=CteEmpresaCFD.EmisorID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CteEmpresaCFD.ProveedorID]
Carpeta=Lista
Clave=CteEmpresaCFD.ProveedorID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Empresa=67
Nombre=255
EmisorID=124
ProveedorID=117
InformacionCompra=101

InfoFormaPago=121
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.CteEmpresaCFD.InformacionCompra]
Carpeta=Lista
Clave=CteEmpresaCFD.InformacionCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Acciones.CteCFDFormaPago]
Nombre=CteCFDFormaPago
Boton=61
NombreEnBoton=S
NombreDesplegar=Metodo de Pago
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteCFDFormaPago
Activo=S
Antes=S
AntesExpresiones=Asigna(info.Cliente,CteEmpresaCFD:CteEmpresaCFD.Cliente)<BR>Asigna(info.Empresa,CteEmpresaCFD:CteEmpresaCFD.Empresa)
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=CteEmpresaCFD.Empresa
CteEmpresaCFD.Empresa=Empresa.Nombre
Empresa.Nombre=CteEmpresaCFD.EmisorID
CteEmpresaCFD.EmisorID=CteEmpresaCFD.ProveedorID
CteEmpresaCFD.ProveedorID=CteEmpresaCFD.InformacionCompra
CteEmpresaCFD.InformacionCompra=CteEmpresaCFD.InfoFormaPago
CteEmpresaCFD.InfoFormaPago=(Fin)

[Lista.CteEmpresaCFD.InfoFormaPago]
Carpeta=Lista
Clave=CteEmpresaCFD.InfoFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[CteCFDFormaPago.Columnas]
FormaPago=304
CuentaPago=124







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CteCFDFormaPago
CteCFDFormaPago=(Fin)
