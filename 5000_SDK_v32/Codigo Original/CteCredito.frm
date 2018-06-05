[Forma]
Clave=CteCredito
Nombre=Políticas de Crédito
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=180
PosicionInicialArriba=211
PosicionInicialAltura=338
PosicionInicialAncho=664
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionColumna1=38
PosicionInicialAlturaCliente=311

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CteCredito
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles

[Ficha.CteCredito.ConLimiteCredito]
Carpeta=Ficha
Clave=CteCredito.ConLimiteCredito
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.LimiteCredito]
Carpeta=Ficha
Clave=CteCredito.LimiteCredito
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.MonedaCredito]
Carpeta=Ficha
Clave=CteCredito.MonedaCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.CteCredito.Credito]
Carpeta=Ficha
Clave=CteCredito.Credito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.Condiciones]
Carpeta=Ficha
Clave=CteCredito.Condiciones
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCredito
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
HojaTitulos=S
HojaMantenerSeleccion=S

[Lista.CteCredito.Credito]
Carpeta=Lista
Clave=CteCredito.Credito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Credito=161
Empresa=56

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
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

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

[Lista.CteCredito.Empresa]
Carpeta=Lista
Clave=CteCredito.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.Empresa]
Carpeta=Ficha
Clave=CteCredito.Empresa
Editar=S
ValidaNombre=S
3D=S
Tamano=15
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.ConCredito]
Carpeta=Ficha
Clave=CteCredito.ConCredito
Editar=S
LineaNueva=S
3D=S
Tamano=15
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.ConDias]
Carpeta=Ficha
Clave=CteCredito.ConDias
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.Dias]
Carpeta=Ficha
Clave=CteCredito.Dias
Editar=S
3D=S
Tamano=20
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=N

[Ficha.CteCredito.ConCondiciones]
Carpeta=Ficha
Clave=CteCredito.ConCondiciones
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.ConLimitePedidos]
Carpeta=Ficha
Clave=CteCredito.ConLimitePedidos
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCredito.LimitePedidos]
Carpeta=Ficha
Clave=CteCredito.LimitePedidos
Editar=S
ValidaNombre=N
3D=S
Tamano=20
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
Eliminar=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CteCredito.Credito
CteCredito.Credito=CteCredito.Empresa
CteCredito.Empresa=CteCredito.MonedaCredito
CteCredito.MonedaCredito=CteCredito.ConCredito
CteCredito.ConCredito=CteCredito.ConLimiteCredito
CteCredito.ConLimiteCredito=CteCredito.ConLimitePedidos
CteCredito.ConLimitePedidos=CteCredito.LimiteCredito
CteCredito.LimiteCredito=CteCredito.LimitePedidos
CteCredito.LimitePedidos=CteCredito.ConDias
CteCredito.ConDias=CteCredito.ConCondiciones
CteCredito.ConCondiciones=CteCredito.Dias
CteCredito.Dias=CteCredito.Condiciones
CteCredito.Condiciones=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CteCredito.Credito
CteCredito.Credito=CteCredito.Empresa
CteCredito.Empresa=(Fin)

[Lista.ListaOrden]
(Inicio)=CteCredito.Credito<TAB>(Acendente)
CteCredito.Credito<TAB>(Acendente)=CteCredito.Empresa<TAB>(Acendente)
CteCredito.Empresa<TAB>(Acendente)=(Fin)
