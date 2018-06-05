[Forma]
Clave=VINAccesorioArt
Nombre=Componentes del VIN
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=216
PosicionInicialArriba=253
PosicionInicialAlturaCliente=483
PosicionInicialAncho=847
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.VIN
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Totalizadores=S
PosicionSeccion1=91
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINAccesorioArt
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
FiltroTipo=Automático
CarpetaVisible=S
PermiteEditar=S
CondicionEdicion=(no Info.Bloqueado) y Usuario.ModificarVINAccesorio
HojaPermiteInsertar=S
HojaPermiteEliminar=S
OtroOrden=S
ListaOrden=(Lista)
HojaMantenerSeleccion=S
HojaIndicador=S
FiltroAutoCampo=VINAccesorioArt.Tipo
FiltroAutoValidar=VINAccesorioArt.Tipo
FiltroEstilo=Folder (1 línea)
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroTodo=S
FiltroTodoFinal=S
FiltroGeneral=VINAccesorioArt.VIN=<T>{Info.VIN}<T> AND VINAccesorioArt.Estatus=<T>ALTA<T>

[Lista.Columnas]
Accesorio=81
Descripcion=157
PrecioDistribuidor=89
PrecioPublico=86
Tipo=106
PrecioContado=93
Bonificacion=85
Estadistica=83
UltimoCambio=94

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

[Lista.VINAccesorioArt.Accesorio]
Carpeta=Lista
Clave=VINAccesorioArt.Accesorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorioArt.Descripcion]
Carpeta=Lista
Clave=VINAccesorioArt.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorioArt.PrecioDistribuidor]
Carpeta=Lista
Clave=VINAccesorioArt.PrecioDistribuidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorioArt.PrecioPublico]
Carpeta=Lista
Clave=VINAccesorioArt.PrecioPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Costo<BR>Precio Crédito<BR>Precio Contado<BR>Bonificaciones
Totalizadores2=Suma( VINAccesorioArt:VINAccesorioArt.PrecioDistribuidor )<BR>Suma( VINAccesorioArt:VINAccesorioArt.PrecioPublico )<BR>Suma( VINAccesorioArt:VINAccesorioArt.PrecioContado )<BR>Suma(VINAccesorioArt:VINAccesorioArt.Bonificacion)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.VINAccesorioArt.Tipo]
Carpeta=Lista
Clave=VINAccesorioArt.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Costo]
Carpeta=(Carpeta Totalizadores)
Clave=Costo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Lista.VINAccesorioArt.PrecioContado]
Carpeta=Lista
Clave=VINAccesorioArt.PrecioContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Precio Crédito]
Carpeta=(Carpeta Totalizadores)
Clave=Precio Crédito
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Precio Contado]
Carpeta=(Carpeta Totalizadores)
Clave=Precio Contado
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Transferir]
Nombre=Transferir
Boton=25
NombreEnBoton=S
NombreDesplegar=&Transferir Componente
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Si<BR>  Forma(<T>EspecificarVINDestino<T>)<BR>Entonces<BR>  ProcesarSQL(<T>xpVINTransferirComponente :tVIN, :nID, :tDestino, :tUsuario, :fFecha<T>, VINAccesorioArt:VINAccesorioArt.VIN, VINAccesorioArt:VINAccesorioArt.ID, Info.VINDestino, Usuario, Hoy) <BR>  Forma.ActualizarVista <BR>Fin
ActivoCondicion=Usuario.VINTransferirComponentes
VisibleCondicion=Usuario.VINTransferirComponentes

[Acciones.VINTipoAccesorio]
Nombre=VINTipoAccesorio
Boton=91
NombreEnBoton=S
NombreDesplegar=&Tipos de Componentes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VINTipoAccesorio
ActivoCondicion=no Info.Bloqueado
VisibleCondicion=no Info.Bloqueado

[Lista.VINAccesorioArt.Bonificacion]
Carpeta=Lista
Clave=VINAccesorioArt.Bonificacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorioArt.Estadistica]
Carpeta=Lista
Clave=VINAccesorioArt.Estadistica
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Bonificaciones]
Carpeta=(Carpeta Totalizadores)
Clave=Bonificaciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Transferir
Transferir=VINTipoAccesorio
VINTipoAccesorio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VINAccesorioArt.Tipo
VINAccesorioArt.Tipo=VINAccesorioArt.Accesorio
VINAccesorioArt.Accesorio=VINAccesorioArt.Descripcion
VINAccesorioArt.Descripcion=VINAccesorioArt.PrecioDistribuidor
VINAccesorioArt.PrecioDistribuidor=VINAccesorioArt.PrecioPublico
VINAccesorioArt.PrecioPublico=VINAccesorioArt.PrecioContado
VINAccesorioArt.PrecioContado=VINAccesorioArt.Bonificacion
VINAccesorioArt.Bonificacion=VINAccesorioArt.Estadistica
VINAccesorioArt.Estadistica=(Fin)

[Lista.ListaOrden]
(Inicio)=VINAccesorioArt.Tipo<TAB>(Acendente)
VINAccesorioArt.Tipo<TAB>(Acendente)=VINAccesorioArt.Accesorio<TAB>(Acendente)
VINAccesorioArt.Accesorio<TAB>(Acendente)=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=VINAccesorioArt.UltimoCambio
VINAccesorioArt.UltimoCambio=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Costo
Costo=Precio Crédito
Precio Crédito=Precio Contado
Precio Contado=Bonificaciones
Bonificaciones=(Fin)
