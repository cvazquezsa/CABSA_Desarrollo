[Forma]
Clave=CxcAplicaDif
Nombre=Aplicar Diferencia
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=602
PosicionInicialArriba=399
PosicionInicialAltura=392
PosicionInicialAncho=715
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
PosicionInicialAlturaCliente=365
PosicionSec1=261

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcAplicaDif
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
ValidarCampos=S
ListaCamposAValidar=CteEnviarA.Nombre
FiltroGeneral=CxcAplicaDif.ID={Afectar.ID}

[Lista.CxcAplicaDif.Mov]
Carpeta=Lista
Clave=CxcAplicaDif.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcAplicaDif.Concepto]
Carpeta=Lista
Clave=CxcAplicaDif.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcAplicaDif.Importe]
Carpeta=Lista
Clave=CxcAplicaDif.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=104
Concepto=126
Importe=83
ClienteEnviarA=80
Referencia=105
Impuestos=83
ImporteTotal=89
Agente=64

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
Totalizadores2=Abs(Info.Saldo)-Suma(CxcAplicaDif:ImporteTotal)
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
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=&Afectar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=Redondea(Abs(Info.Saldo)-Suma(CxcAplicaDif:ImporteTotal))=0.0
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

[Lista.CxcAplicaDif.ClienteEnviarA]
Carpeta=Lista
Clave=CxcAplicaDif.ClienteEnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcAplicaDif.Referencia]
Carpeta=Lista
Clave=CxcAplicaDif.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcAplicaDif.Impuestos]
Carpeta=Lista
Clave=CxcAplicaDif.Impuestos
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
(Inicio)=CxcAplicaDif.Mov
CxcAplicaDif.Mov=CxcAplicaDif.Concepto
CxcAplicaDif.Concepto=CxcAplicaDif.Importe
CxcAplicaDif.Importe=CxcAplicaDif.Impuestos
CxcAplicaDif.Impuestos=ImporteTotal
ImporteTotal=CxcAplicaDif.Referencia
CxcAplicaDif.Referencia=CxcAplicaDif.ClienteEnviarA
CxcAplicaDif.ClienteEnviarA=(Fin)
