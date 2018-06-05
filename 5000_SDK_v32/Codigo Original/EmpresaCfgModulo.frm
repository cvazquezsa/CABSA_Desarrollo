[Forma]
Clave=EmpresaCfgModulo
Nombre=<T>Opciones Módulos - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=401
PosicionInicialArriba=361
PosicionInicialAltura=269
PosicionInicialAncho=477
PosicionColumna1=24
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraAyuda=S
PosicionInicialAlturaCliente=268

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EmpresaCfgModulo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.EmpresaCfgModulo.Modulo]
Carpeta=Ficha
Clave=EmpresaCfgModulo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.EditarConsec]
Carpeta=Ficha
Clave=EmpresaCfgModulo.EditarConsec
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.Situaciones]
Carpeta=Ficha
Clave=EmpresaCfgModulo.Situaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgModulo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EmpresaCfgModulo.Modulo
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
FiltroGeneral=EmpresaCfgModulo.Empresa=<T>{Info.Empresa}<T>

[Lista.EmpresaCfgModulo.Modulo]
Carpeta=Lista
Clave=EmpresaCfgModulo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=81

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

[Ficha.EmpresaCfgModulo.ContXGenerar]
Carpeta=Ficha
Clave=EmpresaCfgModulo.ContXGenerar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.Tiempos]
Carpeta=Ficha
Clave=EmpresaCfgModulo.Tiempos
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.ValidarFechas]
Carpeta=Ficha
Clave=EmpresaCfgModulo.ValidarFechas
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.PeriodosEspeciales]
Carpeta=Ficha
Clave=EmpresaCfgModulo.PeriodosEspeciales
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Acciones.EjercicioEspecial]
Nombre=EjercicioEspecial
Boton=53
NombreEnBoton=S
NombreDesplegar=&Fechas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EjercicioEspecial
Visible=S
ActivoCondicion=EmpresaCfgModulo:EmpresaCfgModulo.PeriodosEspeciales=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(EmpresaCfgModulo:EmpresaCfgModulo.Modulo)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, EmpresaCfgModulo:EmpresaCfgModulo.Modulo)

[Acciones.PeriodoEspecial]
Nombre=PeriodoEspecial
Boton=9
NombreEnBoton=S
NombreDesplegar=&Periodos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PeriodoEspecial
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S
ActivoCondicion=EmpresaCfgModulo:EmpresaCfgModulo.PeriodosEspeciales=<T>Si<T>
EjecucionCondicion=ConDatos(EmpresaCfgModulo:EmpresaCfgModulo.Modulo)
AntesExpresiones=Asigna(Info.Modulo, EmpresaCfgModulo:EmpresaCfgModulo.Modulo)

[Acciones.CerrarPeriodos]
Nombre=CerrarPeriodos
Boton=83
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CerrarPeriodos
Activo=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, EmpresaCfgModulo:EmpresaCfgModulo.Modulo)

[Acciones.ValidarFechasEx]
Nombre=ValidarFechasEx
Boton=30
NombreDesplegar=Excepciones Validación Fechas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgValidarFechasEx
ActivoCondicion=EmpresaCfgModulo.ValidarFechas<><T>No<T>
ConCondicion=S
EjecucionCondicion=ConDatos(EmpresaCfgModulo:EmpresaCfgModulo.Modulo)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, EmpresaCfgModulo:EmpresaCfgModulo.Modulo)
Visible=S

[Ficha.EmpresaCfgModulo.FechaEmision]
Carpeta=Ficha
Clave=EmpresaCfgModulo.FechaEmision
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.FlujoAbierto]
Carpeta=Ficha
Clave=EmpresaCfgModulo.FlujoAbierto
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgModulo.TipoCambio]
Carpeta=Ficha
Clave=EmpresaCfgModulo.TipoCambio
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=CerrarPeriodos
CerrarPeriodos=PeriodoEspecial
PeriodoEspecial=EjercicioEspecial
EjercicioEspecial=ValidarFechasEx
ValidarFechasEx=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCfgModulo.Modulo
EmpresaCfgModulo.Modulo=EmpresaCfgModulo.EditarConsec
EmpresaCfgModulo.EditarConsec=EmpresaCfgModulo.ValidarFechas
EmpresaCfgModulo.ValidarFechas=EmpresaCfgModulo.FechaEmision
EmpresaCfgModulo.FechaEmision=EmpresaCfgModulo.Situaciones
EmpresaCfgModulo.Situaciones=EmpresaCfgModulo.Tiempos
EmpresaCfgModulo.Tiempos=EmpresaCfgModulo.FlujoAbierto
EmpresaCfgModulo.FlujoAbierto=EmpresaCfgModulo.PeriodosEspeciales
EmpresaCfgModulo.PeriodosEspeciales=EmpresaCfgModulo.TipoCambio
EmpresaCfgModulo.TipoCambio=EmpresaCfgModulo.ContXGenerar
EmpresaCfgModulo.ContXGenerar=(Fin)
