[Forma]
Clave=ContDSinOrigen
Nombre=Póliza sin Origen
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=564
PosicionInicialArriba=276
PosicionInicialAlturaCliente=613
PosicionInicialAncho=792
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ValidarCampos=S
ListaCamposAValidar=Cta.Descripcion
HojaAjustarColumnas=S
FiltroGeneral=ContD.ID={Info.ID}

[Lista.ContD.Cuenta]
Carpeta=Lista
Clave=ContD.Cuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContD.SubCuenta]
Carpeta=Lista
Clave=ContD.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContD.Concepto]
Carpeta=Lista
Clave=ContD.Concepto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContD.Debe]
Carpeta=Lista
Clave=ContD.Debe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContD.Haber]
Carpeta=Lista
Clave=ContD.Haber
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContD.ContactoEspecifico]
Carpeta=Lista
Clave=ContD.ContactoEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cuenta=124
SubCuenta=127
Concepto=200
Debe=98
Haber=108
ContactoEspecifico=101

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ContD.Cuenta
ContD.Cuenta=ContD.SubCuenta
ContD.SubCuenta=ContD.Concepto
ContD.Concepto=ContD.Debe
ContD.Debe=ContD.Haber
ContD.Haber=ContD.ContactoEspecifico
ContD.ContactoEspecifico=(Fin)

[Lista.ListaOrden]
(Inicio)=ContD.Renglon<TAB>(Acendente)
ContD.Renglon<TAB>(Acendente)=ContD.RenglonSub<TAB>(Acendente)
ContD.RenglonSub<TAB>(Acendente)=(Fin)
