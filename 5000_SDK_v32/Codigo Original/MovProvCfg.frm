[Forma]
Clave=MovProvCfg
Nombre=Movimientos desde el Prooveedor
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=577
PosicionInicialArriba=408
PosicionInicialAlturaCliente=347
PosicionInicialAncho=771
PosicionColumna1=50
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=381

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovProv
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovProv.Nombre
CarpetaVisible=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=MovProv.Orden<TAB>(Acendente)

[Lista.MovProv.Nombre]
Carpeta=Lista
Clave=MovProv.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovProv
Fuente={Tahoma, 8, Negro, []}
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
PermiteEditar=S

[Ficha.MovProv.Nombre]
Carpeta=Ficha
Clave=MovProv.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.MovProv.Tipo]
Carpeta=Ficha
Clave=MovProv.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.MovProv.Modulo]
Carpeta=Ficha
Clave=MovProv.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Modulo.Nombre]
Carpeta=Ficha
Clave=Modulo.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Plata
ColorFuente=Negro

[Ficha.MovProv.SubModulo]
Carpeta=Ficha
Clave=MovProv.SubModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SubModulo.Nombre]
Carpeta=Ficha
Clave=SubModulo.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Plata
ColorFuente=Negro

[Ficha.MovProv.NivelAcceso]
Carpeta=Ficha
Clave=MovProv.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Nombre=347

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Ficha.MovProv.Mov]
Carpeta=Ficha
Clave=MovProv.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>MovProvOrdenar<T>)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Ordenar
Ordenar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=MovProv.Nombre
MovProv.Nombre=MovProv.Tipo
MovProv.Tipo=MovProv.NivelAcceso
MovProv.NivelAcceso=MovProv.Modulo
MovProv.Modulo=Modulo.Nombre
Modulo.Nombre=MovProv.SubModulo
MovProv.SubModulo=SubModulo.Nombre
SubModulo.Nombre=MovProv.Mov
MovProv.Mov=(Fin)
