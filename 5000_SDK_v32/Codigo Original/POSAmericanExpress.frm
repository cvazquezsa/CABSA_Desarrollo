
[Forma]
Clave=POSAmericanExpress
Icono=0
Modulos=(Todos)
Nombre=American Express

ListaCarpetas=(Lista)
CarpetaPrincipal=Cobro
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
MenuTouchScreen=S
MenuTouchScreenMostrarTeclasFuncion=S
VentanaSiempreAlFrente=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=252
PosicionInicialArriba=303
PosicionInicialAlturaCliente=167
PosicionInicialAncho=776
PosicionCol1=443




ExpresionesAlMostrar=Asigna(Ver.FormasPago, TextoEnLista(SQL(<T>EXEC spPOSMuestraFormasPago<T>)))<BR>Asigna(Info.Codigo, Nulo)
ExpresionesAlActivar=Asigna(Info.Codigo, Nulo)
ListaAcciones=Enter
[POSAmericanExpress.ListaEnCaptura]
(Inicio)=Ver.Total
Ver.Total=Info.Codigo
Info.Codigo=Info.Saldo
Info.Saldo=(Fin)



[FormasPago]
Estilo=Ficha
Clave=FormasPago
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=(Variables)
Fuente={Tahoma, 10, Negro, []}
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S

ListaEnCaptura=Ver.FormasPago
ConFuenteEspecial=S
[Cobro]
Estilo=Ficha
Clave=Cobro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
ConFuenteEspecial=S
Fuente={Tahoma, 14, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S


[Cobro.Info.Codigo]
Carpeta=Cobro
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Cobro.Info.Saldo]
Carpeta=Cobro
Clave=Info.Saldo
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco






AccionAlEnter=Enter
[FormasPago.Ver.FormasPago]
Carpeta=FormasPago
Clave=Ver.FormasPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Plata































































[Acciones.Enter.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Enter]
Nombre=Enter
Boton=0
NombreDesplegar=Enter
Activo=S
Visible=S

TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar



[Cobro.ListaEnCaptura]
(Inicio)=Info.Numero
Info.Numero=Info.Codigo
Info.Codigo=Info.Saldo
Info.Saldo=(Fin)

[Cobro.Info.Numero]
Carpeta=Cobro
Clave=Info.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Forma.ListaCarpetas]
(Inicio)=Cobro
Cobro=FormasPago
FormasPago=(Fin)
