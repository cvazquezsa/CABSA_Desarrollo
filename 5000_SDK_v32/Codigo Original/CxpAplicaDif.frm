[Forma]
Clave=CxpAplicaDif
Nombre=Aplicar Diferencia
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=286
PosicionInicialArriba=342
PosicionInicialAltura=340
PosicionInicialAncho=707
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Totalizadores=S
PosicionSeccion1=87
Comentarios=Afectar.Mov+<T> <T>+Afectar.MovID
Menus=S
VentanaEscCerrar=S
MenuPrincipal=&Archivo
PosicionInicialAlturaCliente=313

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpAplicaDif
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
PermiteEditar=S
HojaAjustarColumnas=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CxpAplicaDif.ID={Afectar.ID}

[Lista.CxpAplicaDif.Mov]
Carpeta=Lista
Clave=CxpAplicaDif.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxpAplicaDif.Concepto]
Carpeta=Lista
Clave=CxpAplicaDif.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxpAplicaDif.Importe]
Carpeta=Lista
Clave=CxpAplicaDif.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=120
Concepto=126
Importe=96
Referencia=108
Impuestos=100
ImporteTotal=112

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Menu=&Archivo
EnMenu=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Diferencia
Totalizadores2=Abs(Info.Saldo)-Suma(CxpAplicaDif:ImporteTotal)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Diferencia
CarpetaVisible=S

[(Carpeta Totalizadores).Diferencia]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=&Afectar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
EnMenu=S
EjecucionCondicion=Redondea(Abs(Info.Saldo)-Suma(CxpAplicaDif:ImporteTotal))=0.0
EjecucionMensaje=<T>Existen Diferencias<T>

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Ce&rrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.CxpAplicaDif.Referencia]
Carpeta=Lista
Clave=CxpAplicaDif.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxpAplicaDif.Impuestos]
Carpeta=Lista
Clave=CxpAplicaDif.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Forma.ListaAcciones]
(Inicio)=Afectar
Afectar=Cancelar
Cancelar=Cerrar
Cerrar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CxpAplicaDif.Mov
CxpAplicaDif.Mov=CxpAplicaDif.Concepto
CxpAplicaDif.Concepto=CxpAplicaDif.Importe
CxpAplicaDif.Importe=CxpAplicaDif.Impuestos
CxpAplicaDif.Impuestos=ImporteTotal
ImporteTotal=CxpAplicaDif.Referencia
CxpAplicaDif.Referencia=(Fin)
